import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InformationsProduct extends StatefulWidget {
  final Item item;
  const InformationsProduct({super.key, required this.item});

  @override
  State<InformationsProduct> createState() => _InformationsProductState();
}

class _InformationsProductState extends State<InformationsProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.selectedItem.toString(),
                style: const TextStyle(color: Color(0xffC6C6C6), fontSize: 13),
              ),
              Text(
                widget.item.productName.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                width: 390,
                child: Text(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  widget.item.description.toString(),
                  style:
                      const TextStyle(color: Color(0xffC6C6C6), fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 4.5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xffFFB341),
                    ),
                    unratedColor:
                        ColorsAppGeneral.borderChannelNotificationColor,
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const Text(
                    '4,5',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '1,7k reviews',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.item.price.toString(),
                style: const TextStyle(
                    color: ColorsAppGeneral.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
