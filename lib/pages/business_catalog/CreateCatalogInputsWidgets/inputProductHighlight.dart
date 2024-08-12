import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';

Widget inputHighlights(nameDescription, controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorsAppGeneral.channelNotificationColor,
            border: Border.all(
                color: ColorsAppGeneral.borderChannelNotificationColor),
          ),
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              hintText: nameDescription,
              hintStyle:
                  const TextStyle(color: Color(0xffAAAAAA), fontSize: 14),
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              labelStyle: const TextStyle(color: ColorsAppGeneral.mainColor),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
