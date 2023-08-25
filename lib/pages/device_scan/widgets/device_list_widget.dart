import 'package:copick_sensor_manage/pages/device_scan/widgets/found_device_info_widget.dart';
import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/loading_screen.dart';

class DeviceListWidget extends StatelessWidget {
  const DeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var blue = Provider.of<BluetoothControlProvider>(context);
    var list = blue.deviceList;
    var size = MediaQuery.of(context).size;
    if (blue.isFinding) {
      blue.findDevices();
      return Expanded(
        child: LoadingScreen(
          text: '기기를 찾는 중이에요...',
        ),
      );
    } else {
      return Expanded(
        child: (list.isEmpty)
            ? Container(
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(NORMALGAP),
                  child: Column(
                    children: [
                      Text('기기를 찾을 수 없어요.\n기기의 연결 상태를 확인해주세요.', style: kContentTextStyle.copyWith(),),

                      ElevatedButton(
                        onPressed: () {
                          blue.deviceResearch();
                        },
                        child: Text('기기 재검색'),
                      )
                    ],
                  ),
                ),
                color: KColors.white,
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
