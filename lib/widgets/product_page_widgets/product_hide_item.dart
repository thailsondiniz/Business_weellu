import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProductHideItem extends StatefulWidget {
  const ProductHideItem({super.key});

  @override
  State<ProductHideItem> createState() => _ProductHideItemState();
}

class _ProductHideItemState extends State<ProductHideItem> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
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
              style: TextStyle(
                  fontSize: 17, color: ColorsAppGeneral.descriptionColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 290,
                  child: Text(
                    'Inactive',
                    style: TextStyle(
                        fontSize: 14, color: ColorsAppGeneral.descriptionColor),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: FlutterSwitch(
                    width: 50.0,
                    height: 25.0,
                    disabled: true,
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
