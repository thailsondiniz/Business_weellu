import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';

class ProductHighlightsWidget extends StatefulWidget {
  final Item item;
  const ProductHighlightsWidget({super.key, required this.item});

  @override
  State<ProductHighlightsWidget> createState() =>
      _ProductHighlightsWidgetState();
}

class _ProductHighlightsWidgetState extends State<ProductHighlightsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: ColorsAppGeneral.bottomBarColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                border: Border.all(
                    width: 0.8,
                    color: ColorsAppGeneral.borderChannelNotificationColor)),
            alignment: Alignment.topLeft,
            child: const Text(
              'Product Highlights',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                    color: ColorsAppGeneral.borderChannelNotificationColor,
                    width: 0.8),
                left: BorderSide(
                    color: ColorsAppGeneral.borderChannelNotificationColor,
                    width: 0.8),
                bottom: BorderSide(
                    color: ColorsAppGeneral.borderChannelNotificationColor,
                    width: 0.8),
              ),
              color: ColorsAppGeneral.channelNotificationColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Brand:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            widget.item.brand.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Model',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            widget.item.model.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Color:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            widget.item.color.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
