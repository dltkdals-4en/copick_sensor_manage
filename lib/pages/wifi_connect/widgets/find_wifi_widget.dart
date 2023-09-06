import 'package:copick_sensor_manage/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/wifi_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class FindWifiWidget extends StatelessWidget {
  const FindWifiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var wifi = Provider.of<WifiProvider>(context);
    if (!wifi.findWifi) {
      wifi.getWifiList();
      return Expanded(child: LoadingScreen(text: '와이파이 찾는중'));
    } else {
      return Expanded(
        child: ListView.separated(
          itemCount: wifi.wifiList.length,
          itemBuilder: (context, index) {
            var item = wifi.wifiList[index];
            return ListTile(
              title: Text('${item.ssid}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.bssid}'),
                  Text('${item.capabilities}'),
                  Text('${item.channelWidth}'),
                ],
              ),
              trailing: ElevatedButton(
                child: Text('연결하기'),
                onPressed: ()  {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return Container();
                  //   },
                  // );
                  // await wifi.connectWifi(item);
                },
              ),
              tileColor: KColors.white,
              contentPadding: EdgeInsets.all(NORMALGAP),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(SMALLGAP),
              // ),
            );
          },
          // padding: EdgeInsets.all(NORMALGAP),
          separatorBuilder: (context, index) => Divider(
            height: 1,
          ),
        ),
      );
    }
    return const Placeholder();
  }
}
