import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:senior_design/ble/ble_device.dart';
import 'package:senior_design/ble/ble_consts.dart';
import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class BLEService extends ChangeNotifier {
  static final FlutterReactiveBle _ble = FlutterReactiveBle();

  bool isBluetoothOn = false;
  bool isReadyToWorkout = false;

  StreamSubscription? _subscription;
  final targetDevices = <BLEDevice>[];

  BLEService() {
    if (disableBluetooth) {
      isBluetoothOn = true;
      isReadyToWorkout = true;
      notifyListeners();
      return;
    }
    isBluetoothOn = false;
    isReadyToWorkout = false;
    notifyListeners();
    _ble.logLevel = LogLevel.verbose;
    _ble.statusStream.listen((status) {
      if (status == BleStatus.ready) {
        isBluetoothOn = true;
        notifyListeners();
      } else {
        isBluetoothOn = false;
      }
    });
  }

  startScan(context) {
    if (disableBluetooth) {
      if (kDebugMode) print("Bluetooth is disabled");
      return;
    }
    if (!isBluetoothOn) {
      if (kDebugMode) print("Bluetooth is off");
      return;
    }
    disconnect();
    targetDevices.clear();
    _subscription = _ble.scanForDevices(
      withServices: [Uuid.parse(sensorServiceUUID)],
      scanMode: ScanMode.lowLatency,
      requireLocationServicesEnabled: false,
    ).listen(
      (device) {
        BLEDevice newDevice = BLEDevice(_ble, device);
        targetDevices.add(newDevice);
        newDevice.isReadyNotifier.addListener(() {
          if (targetDevices.length == numDevices &&
              targetDevices.every((element) => element.isReadyNotifier.value)) {
            isReadyToWorkout = true;
            notifyListeners();
          } else if(newDevice.isReadyNotifier.value == false){
            //disconnect from every device
            for (BLEDevice device in targetDevices) {
              device.disconnect();
            }
            isReadyToWorkout = false;
            notifyListeners();
            Navigator.of(context).pushNamed(RoutesName.workoutConnect);

          } else{
            isReadyToWorkout = false;
            notifyListeners();
          }
        });
        newDevice.connectToDevice();
        if (targetDevices.length == numDevices) {
          stopScan();
        }
      },
      onError: (e) {
        if (kDebugMode) {
          print(e);
        }
      },
      onDone: _onDoneScan(),
    );
  }

  _onDoneScan() {
    stopScan();
  }

  Future<void> stopScan() async {
    try {
      await _subscription?.cancel();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  disconnect() async {
    for (BLEDevice device in targetDevices) {
      await device.disconnect();
    }
    isReadyToWorkout = false;
    notifyListeners();
  }

  beginReading() {
    if (disableBluetooth) return;
    for (BLEDevice device in targetDevices) {
      device.beginReading();
    }
  }

  Map<String, Map<String, List<int>>> getData() {
    if (disableBluetooth) return {};
    Map<String, Map<String, List<int>>> data = {};
    int i = 0;

    for (BLEDevice device in targetDevices) {
      data['dev$i'] = device.getData();
      i++;
    }
    // if(kDebugMode) {
    //   print(data);
    // }
    return data;
  }

  endReading() {
    if (disableBluetooth) return {};
    for (BLEDevice device in targetDevices) {
      device.endReading();
    }
  }

  beginCalibration() {
    if (disableBluetooth) return;
    for (BLEDevice device in targetDevices) {
      device.beginCalibration();
    }
  }

  clearData() {
    if (disableBluetooth) return;
    for (BLEDevice device in targetDevices) {
      device.clearData();
    }
  }
}
