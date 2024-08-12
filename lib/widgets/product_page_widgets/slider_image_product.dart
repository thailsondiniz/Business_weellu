import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/route/api_route.dart';

class SliderImageProduct extends StatefulWidget {
  final Item item;
  const SliderImageProduct({super.key, required this.item});

  @override
  State<SliderImageProduct> createState() => _SliderImageProductState();
}

late List<String> imageUrls;

class _SliderImageProductState extends State<SliderImageProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrls = [
      widget.item.imageUrl.toString(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ImageSlideshow(
        // width: double.infinity,
        initialPage: 0,
        indicatorColor: ColorsAppGeneral.mainColor,
        indicatorBackgroundColor: Colors.grey,
        // onPageChanged: (value) {
        //   print('Page changed: $value');
        // },
        autoPlayInterval: 3000,
        isLoop: true,
        children: imageUrls
            .map(
              (image) => Image.network(
                  '${ApiRota.baseApi}${widget.item.imageUrl}',
                  fit: BoxFit.cover),
            )
            .toList(),
      ),
    );
  }
}
