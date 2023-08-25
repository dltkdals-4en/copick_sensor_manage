import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
import 'package:copick_sensor_manage/utils/data_loading_screen.dart';
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
                        Text("${device.isBonded} //${device.isConnected}"),
                        Text("${device.bondState}"),
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
        child: Text(blue.setString(device)),
        onPressed: () {
          if (!device.isBonded) {}
          showDialog(
            context: context,
            builder: (context) {
              blue.bondDevice(device, index).then((value) {
                Navigator.of(context).pop();
              });
              return DataLoadingScreen(
                text: '기기 등록 중입니다.',
              );
            },
          );
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
