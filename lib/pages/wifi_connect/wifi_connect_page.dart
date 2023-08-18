import 'package:copick_sensor_manage/providers/wifi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiConnectPage extends StatelessWidget {
  const WifiConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    var wifi = Provider.of<WifiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('와이파이 검색하기'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await wifi.getWifiList();
            },
            child: Text("ㅏㅏㅏ"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wifi.wifiList.length,
              itemBuilder: (context, index) {
                var item = wifi.wifiList[index];
                return ListTile(
                  title: Text('${item.bssid}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.ssid}'),
                      Text('${item.capabilities}'),
                      Text('${item.channelWidth}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    child: Text('연결하기'),
                    onPressed: () async{
                       await wifi.connectWifi(item);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
