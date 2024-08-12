import 'package:flutter/material.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/route/api_route.dart';

class AlertDialogZoomImage extends StatefulWidget {
  final Item item;
  const AlertDialogZoomImage({super.key, required this.item});

  @override
  State<AlertDialogZoomImage> createState() => _AlertDialogZoomImageState();
}

class _AlertDialogZoomImageState extends State<AlertDialogZoomImage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      actions: <Widget>[
        Container(
          child: Image.network(
            '${ApiRota.baseApi}${widget.item.imageUrl}',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
