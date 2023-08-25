import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:flutter/material.dart';

class WifiHeaderWidget extends StatelessWidget {
  const WifiHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: KColors.white,
      child: Text('연결할 Wifi를 선택해주세요.'),
    );
  }
}
