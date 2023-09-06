import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/routes/routes/routes.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:copick_sensor_manage/utils/data_loading_screen.dart';
import 'package:copick_sensor_manage/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class FoundDeviceInfoWidget extends StatelessWidget {
  const FoundDeviceInfoWidget(this.device, this.index, {super.key});

  final BluetoothDevice device;
  final int index;

  @override
  Widget build(BuildContext context) {
    var blue = Provider.of<BluetoothControlProvider>(context);
    return ListTile(
      title: Text(
        '${device.name}',
        style: kLabelTextStyle.copyWith(),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            device.address,
            style: kContentTextStyle.copyWith(
                fontWeight: FontWeight.w500, color: KColors.blackGrey),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "isBonded: ${device.isBonded} //isConnected: ${device.isConnected}"),
                        Text("bondState: ${device.bondState}"),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('자세히 보기'),
          ),
          // Text("${device.isBonded} //${device.isConnected}"),
          // Text("${device.bondState}"),
        ],
      ),
      trailing: ElevatedButton(
        child: Text('기기 연동하기'),
        onPressed: () async {
          blue.checkBonded(device);
          await blue.bondDevice(device, index).then((value) async {
            if (value) {
              showDialog(
                context: context,
                builder: (context) {
                  blue.connectBluetooth(device).then((value) {
                    if (blue.isConnected) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.wifiScan);
                    } else {
                      Navigator.pop(context);
                      makeFToast(context, '기기 연결에 실패했습니다. 다시 시도해주세요');
                    }
                  });
                  return DataLoadingScreen();
                },
              );
            }
          });

          // if(!blue.isConnected) {
          //   if (!device.isBonded) {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         blue.bondDevice(device, index).then((value) {
          //           Navigator.of(context).pop();
          //         });
          //         return DataLoadingScreen(
          //           text: '기기 등록 중입니다.',
          //         );
          //       },
          //     );
          //   } else if (device.isBonded) {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         blue.connectBluetooth(device).then((value) {
          //           if (blue.isConnected) {
          //             Navigator.of(context).pop();
          //             Navigator.pushNamed(context, Routes.wifiConnect);
          //           } else {
          //             Navigator.of(context).pop();
          //           }
          //         });
          //         return DataLoadingScreen(
          //           text: '기기 연결 중입니다.',
          //         );
          //       },
          //     );
          //   }
          // }else{
          //   Navigator.pushNamed(context, Routes.wifiConnect);
          // }
        },
      ),
      tileColor: KColors.white,
      contentPadding: EdgeInsets.all(NORMALGAP),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SMALLGAP),
      ),
    );
  }
}
