import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';

Widget productDescription(controller, hintname) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 3,
        ),
        SizedBox(
          width: 420,
          child: TextFormField(
            maxLines: null,
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor insira algum texto*';
              }
              return null;
            },
            style: const TextStyle(color: Colors.white),
            // obscureText: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ColorsAppGeneral.borderChannelNotificationColor,
                    width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              filled: true,
              fillColor: ColorsAppGeneral.channelNotificationColor,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: ColorsAppGeneral.borderChannelNotificationColor,
                    width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: hintname,
              contentPadding: const EdgeInsets.only(left: 15, right: 15),
              hintStyle: const TextStyle(
                  fontSize: 14, color: ColorsAppGeneral.descriptionColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                      color: ColorsAppGeneral.borderChannelNotificationColor,
                      width: 1)),
            ),
          ),
        ),
      ],
    ),
  );
}
