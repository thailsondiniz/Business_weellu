import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Widget snackBarAlertInsertImage() {
  return SnackBar(
    duration: const Duration(milliseconds: 2000),
    showCloseIcon: true,
    content: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  size: 40,
                  color: Colors.amber,
                  PhosphorIcons.warning(
                    PhosphorIconsStyle.regular,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Warning',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 240,
                      child: Text(
                        'Insert an image',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
