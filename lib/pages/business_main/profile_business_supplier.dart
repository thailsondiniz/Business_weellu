import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_category_items.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileBusinessSupplier extends StatefulWidget {
  final String userId;
  final Item item;
  final String dadosUser;
  const ProfileBusinessSupplier(
      {super.key,
      required this.dadosUser,
      required this.userId,
      required this.item});

  @override
  State<ProfileBusinessSupplier> createState() =>
      _ProfileBusinessSupplierState();
}

class _ProfileBusinessSupplierState extends State<ProfileBusinessSupplier> {
  List<Item> catalogItems = [];
  loadCatalogItems() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);

      final List<Item> filteredItems = decodedData
          .map((item) => Item.fromJson(item))
          .where((item) => item.userId == widget.item.userId)
          .toList();

      setState(() {
        catalogItems = filteredItems;
      });
    }
  }

  List<dynamic> data = [];
  functionCategoryItems() async {
    final categoryItems = await LoadCategoryItems().loadCategoryItems();
    setState(() {
      data = categoryItems;
    });
  }

  List<dynamic> descricoes = [];
  functionDescriptionBusiness() async {
    final descriptionBusiness = await LoadCategoryItems().loadCategoryItems();

    setState(() {
      descricoes = descriptionBusiness;
    });
  }

  List<dynamic> dados = [];
  Destaques() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return dados = jsonDecode(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    loadCatalogItems();
    functionDescriptionBusiness();
  }

  @override
  Widget build(BuildContext context) {
    bool isUserProduct = widget.item.userId == widget.userId;
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        actions: [
          Visibility(
            visible: !isUserProduct,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  PhosphorIcons.shoppingCart(PhosphorIconsStyle.regular),
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: isUserProduct,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                size: 20,
                PhosphorIcons.magnifyingGlass(
                  PhosphorIconsStyle.regular,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: ColorsAppGeneral.appBarColor,
        title: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.item.profilePhoto.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.item.nameBusiness.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 15,
                  bottom: 8,
                  top: 8,
                ),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 70,
                    decoration: BoxDecoration(
                      color: ColorsAppGeneral.channelNotificationColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor),
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: 80,
                      decoration: BoxDecoration(
                        color: ColorsAppGeneral.channelNotificationColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: ColorsAppGeneral.mainColor,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 130,
                    decoration: BoxDecoration(
                      color: ColorsAppGeneral.channelNotificationColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor),
                    ),
                    child: const Text(
                      'Smartphone',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 80,
                    decoration: BoxDecoration(
                      color: ColorsAppGeneral.channelNotificationColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor),
                    ),
                    child: const Text(
                      'Tec',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 12, top: 5),
              child: Row(
                children: [
                  const Text(
                    'Novidades',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        color: ColorsAppGeneral.mainColor,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, bottom: 5, right: 10),
              height: 250,
              child: catalogItems.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          catalogItems.isNotEmpty ? catalogItems.length : 1,
                      itemBuilder: (BuildContext context, int index) {
                        final reversedIndex = catalogItems.length - 1 - index;
                        final item = catalogItems[reversedIndex];
                        // if (catalogItems.isEmpty) {
                        //   return noCatalog();
                        // }
                        // final item = catalogItems[index];

                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
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
                              width: 185,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ColorsAppGeneral
                                        .borderChannelNotificationColor,
                                    width: 0.8),
                                color:
                                    ColorsAppGeneral.channelNotificationColor,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child: Image.network(
                                        width: 200,
                                        height: 150,
                                        '${ApiRota.baseApi}${item.imageUrl}',
                                        fit: BoxFit.cover,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8, right: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          // color: Colors.cyan,
                                          width: 210,
                                          child: Text(
                                            item.productName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          // color: Colors.cyan,
                                          width: 210,
                                          child: Text(
                                            item.description.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: ColorsAppGeneral
                                                  .descriptionColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          // color: Colors.cyan,
                                          width: 210,
                                          child: Text(
                                            item.price.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: ColorsAppGeneral.mainColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 12, top: 30, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'More Products',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Visibility(
                    visible: isUserProduct,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const CreateCatalog()),
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 1, bottom: 1),
                          decoration: BoxDecoration(
                              color: ColorsAppGeneral.mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'New Product',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 420,
              child: catalogItems.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          catalogItems.isNotEmpty ? catalogItems.length : 1,
                      itemBuilder: (BuildContext context, int index) {
                        final reversedIndex = catalogItems.length - 1 - index;
                        final item = catalogItems[reversedIndex];

                        // if (catalogItems.isEmpty) {
                        //   return noCatalog();
                        // }
                        // final item = catalogItems[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 2, top: 5),
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
                              height: 110,
                              decoration: BoxDecoration(
                                color:
                                    ColorsAppGeneral.channelNotificationColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: ColorsAppGeneral
                                        .borderChannelNotificationColor,
                                    width: 0.8),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 59, 59, 59),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // width: 80,
                                    // height: 85,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                        child: Image.network(
                                            '${ApiRota.baseApi}${item.imageUrl}',
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 210,
                                          child: Text(
                                            item.productName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 210,
                                          child: Text(
                                            item.description.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: ColorsAppGeneral
                                                  .descriptionColor,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),

                                        // Text(
                                        //   data[0]['categoriaSelecionada'],
                                        //   style: const TextStyle(
                                        //     color: ColorsAppGeneral
                                        //         .descriptionColor,
                                        //     fontSize: 11,
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 210,
                                          child: Text(
                                            item.price.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: ColorsAppGeneral.mainColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
