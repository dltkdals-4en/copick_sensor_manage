import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiProvider with ChangeNotifier {
  List<WiFiAccessPoint> wifiList = [];
  WiFiForIoTPlugin wiFiForIoTPlugin = WiFiForIoTPlugin();

  scanWifiList() {}

  Future<void> startScan() async {
    await WiFiScan.instance.startScan().then((value) {
      print(value);
      notifyListeners();
    });
  }

  Future<void> getWifiList() async {
    wifiList = await WiFiScan.instance.getScannedResults();
    print(wifiList);
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
