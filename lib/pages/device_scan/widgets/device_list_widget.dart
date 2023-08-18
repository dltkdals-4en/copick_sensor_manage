import 'package:copick_sensor_manage/pages/device_scan/widgets/found_device_info_widget.dart';
import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/loading_screen.dart';

class DeviceListWidget extends StatelessWidget {
  const DeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var blue = Provider.of<BluetoothControlProvider>(context);
    var list = blue.deviceList;
    if (blue.isFinding) {
      blue.findDevices();
      return Expanded(
        child: LoadingScreen(
          text: '기기를 찾는 중이에요...',
        ),
      );
    } else {
      return Expanded(
        child: (blue.isFinding)
            ? Container(
                child: Text('기기 없음'),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return FoundDeviceInfoWidget(list[index].device, index);
                }),
      );
    }
  }
}
