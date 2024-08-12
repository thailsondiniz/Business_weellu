import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/pages/business_product_widgets/edit_product_page.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:flutter_project_business/widgets/alert_dialog_widgets/alertdialog_delete_product.dart';
import 'package:flutter_project_business/widgets/alert_dialog_widgets/alertdialog_zoom_image.dart';
import 'package:flutter_project_business/widgets/product_page_widgets/informations_product.dart';
import 'package:flutter_project_business/widgets/product_page_widgets/product_hide_item.dart';
import 'package:flutter_project_business/widgets/product_page_widgets/product_highlights_widget.dart';
import 'package:flutter_project_business/widgets/product_page_widgets/show_catalog_share_send.dart';
import 'package:flutter_project_business/widgets/product_page_widgets/slider_image_product.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Product extends StatefulWidget {
  final String userId;
  final Item item;
  final String dadosUser;
  const Product(
      {super.key,
      required this.item,
      required this.userId,
      required this.dadosUser});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);

  int activePage = 0;
  int _currentPage = 0;
  bool status = false;

  late List<String> imageUrls;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    // imageUrls = [
    //   widget.item.imageUrl.toString(),
    // ];
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  void deleteItem(String itemId, String imageUrl) async {
    final url = Uri.parse('${ApiRota.baseApi}itens/$itemId');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('item excluido com sucesso');
      functionDestaque();
    } else {
      print('Erro ao excluir o item: ${response.statusCode}');
    }
  }

  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  @override
  void dispose() {
    functionDestaque();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUserProduct = widget.item.userId == widget.userId;
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
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
        ],
      ),
      bottomNavigationBar: Container(
        color: ColorsAppGeneral.appBarColor,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isUserProduct)
                  Visibility(
                    visible: isUserProduct,
                    child: SizedBox(
                      width: 140,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogDeleteProduct(
                                item: widget.item,
                                userId: widget.userId,
                                dadosUser: widget.dadosUser,
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xffEE4848), // Cor de fundo vermelha
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Bordas quadradas
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                Visibility(
                  visible: isUserProduct,
                  child: const SizedBox(
                    width: 20,
                  ),
                ),
                Visibility(
                  visible: isUserProduct,
                  child: SizedBox(
                    width: 140,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProductPage(
                                    item: widget.item,
                                    userId: widget.userId,
                                    dadosUser: widget.dadosUser,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ColorsAppGeneral.mainColor, // Cor de fundo vermelha
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Bordas quadradas
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isUserProduct,
                  child: SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProductPage(
                              item: widget.item,
                              userId: widget.userId,
                              dadosUser: widget.dadosUser,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            ColorsAppGeneral.mainColor, // Cor de fundo vermelha
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Bordas quadradas
                        ),
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialogZoomImage(
                  item: widget.item,
                ),
              ),
              child: SliderImageProduct(
                item: widget.item,
              ),
            ),
            InformationsProduct(
              item: widget.item,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowCatalogShareSend(
                  userId: widget.userId,
                  item: widget.item,
                  dadosUser: widget.dadosUser,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ProductHighlightsWidget(
              item: widget.item,
            ),
            const ProductHideItem(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(
    imagesLength,
    (index) {
      return Container(
        margin: const EdgeInsets.only(top: 5, left: 3, right: 3),
        width: 8,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index
                ? const Color(0xffDADADA)
                : const Color(0xff505050),
            shape: BoxShape.circle),
      );
    },
  );
}
