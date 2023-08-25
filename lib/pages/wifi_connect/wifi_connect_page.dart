import 'package:copick_sensor_manage/pages/wifi_connect/widgets/wifi_header_widget.dart';
import 'package:copick_sensor_manage/providers/wifi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class WifiConnectPage extends StatelessWidget {
  const WifiConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wifi = Provider.of<WifiProvider>(context);
    // wifi.getWifiList();
    if (!wifi.findWifi) wifi.getWifiList();
    return Scaffold(
      appBar: AppBar(
        title: Text('와이파이 검색하기'),
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
          Expanded(
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
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container();
                        },
                      );
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
          ),
        ],
      ),
    );
  }
}
