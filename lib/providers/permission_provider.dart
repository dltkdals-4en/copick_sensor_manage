import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider with ChangeNotifier {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  bool bluetoothCheck = false;

  Future<void> checkBluetoothPermission() async {
    var deviceData = await deviceInfoPlugin.androidInfo;
    var deviceSdk = deviceData.version.sdkInt;
    print(deviceSdk);
    if (deviceSdk > 30) {
      print('over 30');
      var status = await Permission.bluetoothConnect.status;
      print(status);
      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.bluetoothAdvertise,
        ].request();
        print(statuses);
        bluetoothCheck = true;
        notifyListeners();
      } else if (status.isGranted) {
        bluetoothCheck = true;
        notifyListeners();
      }
    } else {
      print('not over 30');
      var status = await Permission.bluetooth.status;

      if (status.isDenied) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetooth,
        ].request();
        print(statuses);
        bluetoothCheck = true;
        notifyListeners();
      }
    }
  }
}
