import 'package:copick_sensor_manage/pages/device_scan/device_scan_page.dart';
import 'package:copick_sensor_manage/pages/wifi_connect/wif_scan_page.dart';
import 'package:copick_sensor_manage/providers/permission_provider.dart';
import 'package:copick_sensor_manage/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/blue_provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var permission = Provider.of<PermissionProvider>(context);

    if (permission.bluetoothCheck == false) {
      permission.checkBluetoothPermission();
      return LoadingScreen();
    } else {
      return DeviceScanPage();
    }
  }
}
