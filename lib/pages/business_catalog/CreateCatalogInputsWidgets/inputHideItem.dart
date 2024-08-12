import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HideItem extends StatefulWidget {
  const HideItem({super.key});

  @override
  State<HideItem> createState() => _HideItemState();
}

class _HideItemState extends State<HideItem> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ColorsAppGeneral.channelNotificationColor,
          border: Border.all(
              color: ColorsAppGeneral.borderChannelNotificationColor,
              width: 0.8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hide item',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 300,
                  child: Text(
                    'This item will be hide in your catalog to your followers',
                    style: TextStyle(fontSize: 12, color: Color(0xffBCBCBC)),
                  ),
                ),
                Container(
                  child: FlutterSwitch(
                    width: 50.0,
                    height: 25.0,
                    activeColor: ColorsAppGeneral.mainColor,
                    toggleSize: 25.0,
                    value: status,
                    borderRadius: 20.0,
                    // padding: 8.0,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
