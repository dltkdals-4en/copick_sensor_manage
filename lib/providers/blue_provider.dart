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
  bool isBonded = false;
  bool isConnected = false;
  BluetoothDevice? selectedDevice;

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

  void checkBonded(BluetoothDevice device) {
    isBonded = device.isBonded;
    notifyListeners();
  }

  Future<bool> bondDevice(BluetoothDevice device, int index) async {
    print('before ${isBonded}');
    if (!isBonded) {
      await FlutterBluetoothSerial.instance
          .bondDeviceAtAddress(device.address)
          .then((value) {
        print('value $value');
        if (value == true) {
          selectedDevice = device;
          deviceList[index] = BluetoothDiscoveryResult(
              device: BluetoothDevice(
                name: device.name,
                address: device.address,
                bondState: BluetoothBondState.bonded,
              ),
              rssi: deviceList[index].rssi);
          isBonded = true;
          notifyListeners();
        }
      });
    }
    print('after ${isBonded}');
    return isBonded;
    // print('isBonded: ${device.isBonded}');
    // await FlutterBluetoothSerial.instance
    //     .bondDeviceAtAddress(device.address)
    //     .then((value) {
    //   print('value $value');
    //   if(value ==true ) {
    //     selectedDevice = device;
    //     deviceList[index] = BluetoothDiscoveryResult(
    //         device: BluetoothDevice(
    //           name: device.name,
    //           address: device.address,
    //           bondState: BluetoothBondState.bonded,
    //         ),
    //         rssi: deviceList[index].rssi);
    //     notifyListeners();
    //   }
    // });
  }

  Future<void> connectBluetooth(BluetoothDevice device) async {
    await BluetoothConnection.toAddress(device.address).then((value) {
      isConnected = value.isConnected;
      connection = value;
      selectedDevice = device;
      notifyListeners();
    });
  }

  Future<void> disconnectBluetooth() async {
    await connection!.close().then((value) {
      initAll();
      notifyListeners();
    });
  }

  initAll() {
    connection = null;
    selectedDevice = null;
    isBonded = false;
    isConnected = false;
  }
}
