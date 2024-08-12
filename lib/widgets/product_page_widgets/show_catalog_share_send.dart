import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_category.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_main/profile_business_supplier.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ShowCatalogShareSend extends StatefulWidget {
  final String userId;
  final Item item;
  final String dadosUser;
  const ShowCatalogShareSend(
      {super.key,
      required this.userId,
      required this.item,
      required this.dadosUser});

  @override
  State<ShowCatalogShareSend> createState() => _ShowCatalogShareSendState();
}

class _ShowCatalogShareSendState extends State<ShowCatalogShareSend> {
  // IconData teste = "PhosphorIcons.list(PhosphorIconsStyle.regular)" as IconData;
  List<dynamic> dadosCategory = [];
  functionCategory() async {
    final categoryItems = await LoadCategory().Category();
    setState(() {
      dadosCategory = categoryItems;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isUserProduct = widget.item.userId != widget.userId;
    // print(teste.runtimeType);
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileBusinessSupplier(
                        userId: widget.userId,
                        dadosUser: widget.dadosUser,
                        item: widget.item,
                      ),
                    ),
                  );
                },
                icon: Icon(
                    size: 30,
                    PhosphorIcons.storefront(PhosphorIconsStyle.regular),
                    color: ColorsAppGeneral.mainColor),
              ),
              const Text(
                'Catalog',
                style:
                    TextStyle(color: ColorsAppGeneral.mainColor, fontSize: 15),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  PhosphorIcons.shareNetwork(PhosphorIconsStyle.regular),
                  size: 30,
                  color: ColorsAppGeneral.mainColor,
                ),
              ),
              const Text('Share',
                  style: TextStyle(
                      color: ColorsAppGeneral.mainColor, fontSize: 15))
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  PhosphorIcons.shareFat(PhosphorIconsStyle.regular),
                  size: 30,
                  color: ColorsAppGeneral.mainColor,
                ),
              ),
              const Text('Send',
                  style: TextStyle(
                      color: ColorsAppGeneral.mainColor, fontSize: 15))
            ],
          ),
          if (isUserProduct)
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.shoppingCart(PhosphorIconsStyle.regular),
                    size: 30,
                    color: ColorsAppGeneral.mainColor,
                  ),
                ),
                const Text('Add to cart',
                    style: TextStyle(
                        color: ColorsAppGeneral.mainColor, fontSize: 15))
              ],
            ),
        ],
      ),
    );
  }
}
