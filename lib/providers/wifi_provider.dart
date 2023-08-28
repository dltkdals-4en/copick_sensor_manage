import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiProvider with ChangeNotifier {
  bool findWifi = false;
  List<WiFiAccessPoint> wifiList = List<WiFiAccessPoint>.empty(growable: true);
  WiFiForIoTPlugin wiFiForIoTPlugin = WiFiForIoTPlugin();

  scanWifiList() {}

  Future<void> startScan() async {
    await WiFiScan.instance.startScan().then((value) async{
      print(value);
      var i = await WiFiScan.instance.canStartScan();

      notifyListeners();
    });
  }

  Future<void> getWifiList() async {
    final can =
    await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
      // get scanned results
        wifiList = await WiFiScan.instance.getScannedResults();
        findWifi = true;
        print('find Wifi ${wifiList.length}');
        notifyListeners();
        // ...
        break;
    // ... handle other cases of CanGetScannedResults values
      case CanGetScannedResults.notSupported:
      // TODO: Handle this case.
        break;
      case CanGetScannedResults.noLocationPermissionRequired:
      // TODO: Handle this case.
        break;
      case CanGetScannedResults.noLocationPermissionDenied:
      // TODO: Handle this case.
        break;
      case CanGetScannedResults.noLocationPermissionUpgradeAccuracy:
      // TODO: Handle this case.
        break;
      case CanGetScannedResults.noLocationServiceDisabled:
      // TODO: Handle this case.
        break;
    }

  }

  initWifi() {
    findWifi = false;
    getWifiList();
    notifyListeners();
  }

  Future<void> connectWifi(WiFiAccessPoint item) async {
    await WiFiForIoTPlugin.connect(
      item.ssid,
      bssid: item.bssid,
      password: '1108196272',
      security: NetworkSecurity.WPA,
    ).then((value) => print(value));
  }
}
