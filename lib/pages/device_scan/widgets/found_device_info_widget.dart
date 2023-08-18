import 'package:copick_sensor_manage/providers/blue_provider.dart';
import 'package:copick_sensor_manage/utils/colors.dart';
import 'package:copick_sensor_manage/utils/constants.dart';
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
      title: Text('${device.name}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(device.address),
          Text("${device.isBonded} //${device.isConnected}"),
          Text("${device.bondState}"),

        ],
      ),
      trailing: ElevatedButton(
        child: Text(blue.setString(device)),
        onPressed: () {
            if(!device.isBonded){

            }
            blue.bondDevice(device, index);
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
