import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselProduct extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CarouselProduct(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<CarouselProduct> createState() => _CarouselProductState();
}

class _CarouselProductState extends State<CarouselProduct> {
  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  @override
  void initState() {
    super.initState();
    functionDestaque();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dados.length,
        itemBuilder: (context, index) {
          final reversedIndex = dados.length - 1 - index;
          final itemMap = dados[reversedIndex];
          final item = Item.fromJson(itemMap);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(
                          item: item,
                          userId: widget.userId,
                          dadosUser: widget.dadosUser,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 125,
                    height: 178,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorsAppGeneral
                                .borderChannelNotificationColor),
                        borderRadius: BorderRadius.circular(10),
                        color: ColorsAppGeneral.channelNotificationColor),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 110,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                '${ApiRota.baseApi}${item.imageUrl}',
                                maxHeight: 178,
                                maxWidth: 120,
                              ),
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.grey[300],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: 140,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(127, 31, 31, 31),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            height: 33,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                            '${item.profilePhoto}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                //  Image.network(
                                //         item.profilePhoto.toString(),
                                //         fit: BoxFit.cover,
                                //       ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    item.nameBusiness.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 82,
                          left: 70,
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(127, 31, 31, 31),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      '0,0',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 111,
                          left: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: 115,
                                  child: Text(
                                    item.productName.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  item.price.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Open',
                                        style: TextStyle(
                                            color: ColorsAppGeneral.mainColor,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Color(0xFF7B7B7B),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '5,3km',
                                        style: TextStyle(
                                            color: Color(0xFF7B7B7B),
                                            fontSize: 12),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
