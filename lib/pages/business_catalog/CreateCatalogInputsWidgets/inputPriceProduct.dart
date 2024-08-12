import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:intl/intl.dart';

Widget price(controller, hintname) {
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  String formatCurrency(String value) {
    // Remova qualquer formatação monetária do valor atual
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    double parsedValue = double.tryParse(cleanedValue)! /
        100; // Divida por 100 para considerar os centavos
    return currencyFormat.format(parsedValue);
  }

  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 200, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 3,
        ),
        SizedBox(
          // width: 200,
          child: TextFormField(
            onChanged: (value) {
              final formattedValue = formatCurrency(value);
              controller.value = TextEditingValue(
                text: formattedValue,
                selection: TextSelection.collapsed(
                  offset: formattedValue.length,
                ),
              );
            },
            keyboardType: TextInputType.number,
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
