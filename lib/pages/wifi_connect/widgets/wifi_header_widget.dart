import 'package:copick_sensor_manage/providers/wifi_provider.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiHeaderWidget extends StatelessWidget {
  const WifiHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var wifi = Provider.of<WifiProvider>(context);
    return Container(
      width: size.width,
      color: KColors.white,
      child: Row(
        children: [
          Text('연결할 Wifi를 선택해주세요.'),
          ElevatedButton(onPressed: () {
            wifi.startScan();
          }, child: Text('kkk'))
        ],
      ),
    );
  }
}
