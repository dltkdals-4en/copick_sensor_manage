import 'package:copick_sensor_manage/pages/device_scan/widgets/device_list_widget.dart';
import 'package:copick_sensor_manage/pages/device_scan/widgets/header_widget.dart';
import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:copick_sensor_manage/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceScanPage extends StatelessWidget {
  const DeviceScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    var blue = Provider.of<BluetoothControlProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('센서 검색 페이지'),
        actions: [
          IconButton(
            onPressed: () {
              blue.deviceResearch();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              print(blue.isFinding);
            },
            icon: Icon(Icons.padding),
            color: KColors.black,
          )
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          kBigH,
          DeviceListWidget(),
        ],
      ),
    );
  }
}
