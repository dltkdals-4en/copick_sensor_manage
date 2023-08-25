import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/blue_provider.dart';

class DeviceScanHeaderWidget extends StatelessWidget {
  const DeviceScanHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var blue = Provider.of<BluetoothControlProvider>(context);
    var list = blue.deviceList;
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          color: KColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(NORMALGAP),
          child: Text('${list.length} 개의 기기를 찾았어요.', style: kHeaderTextStyle.copyWith(),),
        ));
  }
}
