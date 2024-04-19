import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:senior_design/ble/ble_consts.dart';

class BLEDevice {
  StreamSubscription<ConnectionStateUpdate>? _connection;
  List<Service> services = [];
  StreamSubscription<List<int>>? _readSubscription;
  ValueNotifier<bool> isReadyNotifier = ValueNotifier<bool>(false);

  List<int> X = [];
  List<int> Y = [];
  List<int> Z = [];

  var reconnectCounter = 0;

  dynamic _dataCharacteristic;
  dynamic _configCharacteristic;

  final FlutterReactiveBle _ble;
  final DiscoveredDevice targetDevice;

  BLEDevice(this._ble, this.targetDevice);

  connectToDevice() {
    _connection = _ble
        .connectToDevice(
      id: targetDevice.id,
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((state) async {
      if (state.connectionState == DeviceConnectionState.connected) {
        if (kDebugMode) print('Connected');
        await Future.delayed(const Duration(seconds: 1));
        getCharacteristics();
      }
      if (state.connectionState == DeviceConnectionState.disconnected) {
        isReadyNotifier.value = false;
        if (reconnectCounter < reconnectAttempts) {
          if (kDebugMode) print('Reconnecting...');
          reconnectCounter++;
          connectToDevice();
        }
      }
    }, onError: (e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  getCharacteristics() async {
    await _ble.discoverAllServices(targetDevice.id);
    services = await _ble.getDiscoveredServices(targetDevice.id);
    for (var service in services) {
      if (kDebugMode) print(service);
      for (var characteristic in service.characteristics) {
        if (kDebugMode) print(characteristic);
        if (characteristic.id.toString() == sensorDataUUID) {
          _dataCharacteristic = characteristic;
        }
        if (characteristic.id.toString() == sensorConfigUUID) {
          _configCharacteristic = characteristic;
        }
      }
    }
    isReadyNotifier.value =
        _dataCharacteristic != null && _configCharacteristic != null;
    if (isReadyNotifier.value) reconnectCounter = 0;
  }

  Future<void> beginCalibration() async {
    await _configCharacteristic.write([0x01]);
  }

  static const int max = 32767;
  static const int sub = 65536;

  int convert(int data) {
    if (data > max) {
      return data - sub;
    }
    return data;
  }

  Future<void> beginReading() async {
    _readSubscription = _dataCharacteristic.subscribe().listen((event) {
      int gyroX = convert(event[0] | (event[1] << 8));
      int gyroY = convert(event[2] | (event[3] << 8));
      int gyroZ = convert(event[4] | (event[5] << 8));
      // int accelX = convert(event[6] | (event[7] << 8));
      // int accelY = convert(event[8] | (event[9] << 8));
      // int accelZ = convert(event[10] | (event[11] << 8));

      // int timestamp =
      // event[12] | (event[13] << 8) | (event[14] << 16) | (event[15] << 24);

      X.add(gyroX);
      Y.add(gyroY);
      Z.add(gyroZ);
    });
  }

  Future<void> endReading() async {
    if (_readSubscription != null) {
      await _readSubscription!.cancel();
      _readSubscription = null;
    }
  }

  Map<String, List<int>> getData() {
    return {
      'x': X,
      'y': Y,
      'z': Z,
    };
  }

  Future<void> disconnect() async {
    try {
      await _connection?.cancel();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
