import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:senior_design/ble/ble_device.dart';
import 'package:senior_design/ble/ble_consts.dart';
import 'package:flutter/material.dart';

class BLEService extends ChangeNotifier {
  static final FlutterReactiveBle _ble = FlutterReactiveBle();

  bool isBluetoothOn = false;
  bool isReadyToWorkout = false;
  bool inWorkoutFlow = false;

  var pagesAway = 0;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Please ensure Bluetooth permissions are enabled in the Settings.")),
      );
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
        BLEDevice newDevice = BLEDevice(_ble, device, device.name);
        targetDevices.add(newDevice);
        newDevice.isReadyNotifier.addListener(() {
          if (targetDevices.length == numDevices &&
              targetDevices.every((element) => element.isReadyNotifier.value)) {
            isReadyToWorkout = true;
            notifyListeners();
          } else if (newDevice.isReadyNotifier.value == false &&
              inWorkoutFlow) {
            disconnect();
            popMultiple(context, pagesAway);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("One or more Bluetooth devices disconnected.")),
            );
          } else {
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
    inWorkoutFlow = false;
    isReadyToWorkout = false;
    targetDevices.clear();
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
    for (BLEDevice device in targetDevices) {
      data[device.name] = device.getData();
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

  void setPagesAway(int pages) {
    pagesAway = pages;
  }

  void increasePagesAway() {
    pagesAway++;
  }

  void decreasePagesAway() {
    pagesAway--;
  }

  void setInWorkoutFlow(bool inFlow) {
    inWorkoutFlow = inFlow;
  }

  void popMultiple(BuildContext context, int count) {
    int popCount = 0;
    Navigator.popUntil(context, (route) {
      return popCount++ >= count;
    });
  }
}
