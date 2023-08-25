import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiProvider with ChangeNotifier {
  bool findWifi = false;
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
    await WiFiScan.instance.getScannedResults().then((value) {
      wifiList = value;
      findWifi = true;
      print('find Wifi ${wifiList.length}');
      notifyListeners();
    });

    // await startScan().then((value) async {
    //    // if(value == true){
    //    //
    //    // }
    //  });
  }

  initWifi() {
    wifiList.clear();
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
