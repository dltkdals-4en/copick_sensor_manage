import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothControlProvider with ChangeNotifier {
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  bool isFinding = true;
  BluetoothConnection? connection;
  List<BluetoothDiscoveryResult> deviceList =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;
  bool isConnected = true;
  findDevices() {
    if (streamSubscription == null) {
      streamSubscription =
          FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
        final existingIndex = deviceList.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0) {
          deviceList[existingIndex] = r;
        } else {
          var deviceName = (r.device.name != null) ? r.device.name : '';
          if (deviceName!.contains('4EN')) {
            deviceList.add(r);
          }
        }
      });

      streamSubscription!.onDone(() {
        print('done!');
        isFinding = false;
        notifyListeners();
      });
      streamSubscription!.onError((e) {
        print('stream E : $e');
      });
    }
  }

  void deviceResearch() {
    deviceList.clear();
    streamSubscription = null;
    isFinding = true;

    notifyListeners();
  }

  String setString(BluetoothDevice device) {
    if (!device.isBonded && !device.isConnected) {
      return '기기 등록하기';
    } else {
      return '기기 연결하기';
    }
  }

  Future<void> bondDevice(BluetoothDevice device, int index) async {
    print(device.isBonded);
    if (device.isBonded) {
      await FlutterBluetoothSerial.instance
          .removeDeviceBondWithAddress(device.address)
          .then((value) {
        deviceList[index] = BluetoothDiscoveryResult(
            device: BluetoothDevice(
              name: device.name,
              address: device.address,
              bondState: BluetoothBondState.none,
            ),
            rssi: deviceList[index].rssi);
        notifyListeners();
      });
    } else {
      await FlutterBluetoothSerial.instance
          .bondDeviceAtAddress(device.address)
          .then((value) {
        deviceList[index] = BluetoothDiscoveryResult(
            device: BluetoothDevice(
              name: device.name,
              address: device.address,
              bondState: BluetoothBondState.bonded,
            ),
            rssi: deviceList[index].rssi);
        notifyListeners();
      });
    }
  }

  Future<void> connectBluetooth(BluetoothDevice device) async {
    await BluetoothConnection.toAddress(device.address).then((value) {
      isConnected = value.isConnected;
      notifyListeners();
    });
  }
}
