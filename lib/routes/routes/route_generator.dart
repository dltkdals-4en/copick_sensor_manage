


import 'package:copick_sensor_manage/pages/bluetooth_connect/bluetooth_connect_page.dart';
import 'package:copick_sensor_manage/pages/device_scan/device_scan_page.dart';
import 'package:copick_sensor_manage/pages/pairing_device/pairing_device_page.dart';
import 'package:copick_sensor_manage/routes/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../pages/splash/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      // case Routes.root:
      //   return MaterialPageRoute(
      //     builder: (context) => RootPage(),
      //   );
      // case Routes.login:
      //   return MaterialPageRoute(
      //     builder: (context) => LoginPage(),
      //   );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashPage(),
        );
      case Routes.bluetoothScan:
        return MaterialPageRoute(
          builder: (context) => DeviceScanPage(),
        );

      case Routes.bluetoothConnect:
        return MaterialPageRoute(
          builder: (context) => BluetoothConnectPage(),
        );
      case Routes.pairingDevice:
        return MaterialPageRoute(
          builder: (context) => PairingDevicePage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
