import 'package:copick_sensor_manage/pages/wifi_connect/widgets/find_wifi_widget.dart';
import 'package:copick_sensor_manage/pages/wifi_connect/widgets/wifi_header_widget.dart';
import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/providers/wifi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/loading_screen.dart';

class WifiScanPage extends StatelessWidget {
  const WifiScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wifi = Provider.of<WifiProvider>(context);
    var blue = Provider.of<BluetoothControlProvider>(context);
    // wifi.getWifiList();

    return Scaffold(
      appBar: AppBar(
        title: Text('와이파이 검색하기'),
        leading: BackButton(
          onPressed: () {
            blue.disconnectBluetooth();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              wifi.initWifi();
            },
            icon: Icon(Icons.refresh),
            color: KColors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          WifiHeaderWidget(),
          FindWifiWidget(),
        ],
      ),
    );
  }
}
