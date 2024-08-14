import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/grid_category.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/listview_category_all.dart';
import 'package:http/http.dart' as http;

class CategoryHome extends StatefulWidget {
  final String userId;
  final String dadosUser;
  final String bankai;
  const CategoryHome({
    super.key,
    required this.bankai,
    required this.userId,
    required this.dadosUser,
  });

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  List<Item> catalogItems = [];
  void loadCatalogItems() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Item> items = decodedData
          .map((item) => Item.fromJson(item))
          .where((item) => item.selectedItem == widget.bankai)
          .toList();
      setState(() {
        catalogItems = items;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCatalogItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xff262626),
          ),
          child: BottomNavigatorBar(
            userId: widget.userId,
            dadosUser: widget.dadosUser,
          )),
      body: SizedBox(
        height: 700,
        child: ListView.builder(
          itemCount: catalogItems.length,
          itemBuilder: (context, index) {
            final item = catalogItems[index];
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorsAppGeneral.channelNotificationColor,
                          borderRadius: BorderRadius.circular(5)),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              width: 130,
                              height: 100,
                              child: Image.network(
                                '${ApiRota.baseApi}${item.imageUrl}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName ?? 'No Name',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                item.description ?? 'No Description',
                                style: const TextStyle(
                                    color: ColorsAppGeneral.descriptionColor),
                              ),
                              Text(
                                item.selectedItem ?? 'No Description',
                                style: const TextStyle(
                                    color: ColorsAppGeneral.descriptionColor),
                              ),
                              Text(
                                item.price ?? 'No Price',
                                style: const TextStyle(
                                    color: ColorsAppGeneral.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ListTile(
                  //   leading: Image.network(
                  //     '${ApiRota.baseApi}${item.imageUrl}',
                  //     fit: BoxFit.cover,
                  //     width: 200,
                  //     height: 200,
                  //   ),
                  //   title: Text(
                  //     item.productName ?? 'No Name',
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  //   subtitle: Text(
                  //     item.description ?? 'No Description',
                  //     style: const TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
