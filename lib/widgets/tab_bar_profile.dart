import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:http/http.dart' as http;

class TabBarProfile extends StatefulWidget {
  const TabBarProfile({super.key});

  @override
  State<TabBarProfile> createState() => _TabBarProfileState();
}

class _TabBarProfileState extends State<TabBarProfile>
    with SingleTickerProviderStateMixin {
  List<Item> catalogItems = [];
  void loadCatalogItems() async {
    Uri url = Uri.parse('http://10.0.0.122:3000/itens');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Item> items =
          decodedData.map((item) => Item.fromJson(item)).toList();
      setState(() {
        print(items);
        catalogItems = items;
      });
    }
  }

  List<dynamic> data = [];
  void loadCategoryItems() async {
    Uri url = Uri.parse('http://10.0.0.122:3000/CategoriaSelecionada');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        // print(data);
      });
    }
  }

  List<dynamic> descricoes = [];
  void loadDescricaoBusiness() async {
    Uri url = Uri.parse('http://10.0.0.122:3000/DescricaoNegocio');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        descricoes = jsonDecode(response.body);
        // print(descricoes);
      });
    }
  }

  void deleteItem(String itemId, String imageUrl) async {
    final url = Uri.parse('http://10.0.0.122:3000/itens/$itemId');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      loadCatalogItems();
    } else {
      print('Erro ao excluir o item: ${response.statusCode}');
    }
  }

  late TabController tabController2;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    loadCatalogItems();
    loadCategoryItems();
    loadDescricaoBusiness();
    // tabController = TabController(length: 3, vsync: this);
    tabController2 = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // tabController.dispose();
    tabController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              controller: tabController2,
              labelColor: ColorsAppGeneral.mainColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: ColorsAppGeneral.mainColor,
              tabs: [
                Column(
                  children: [
                    Tab(
                      icon: Image.asset(
                        'lib/image/moments.png',
                        height: 20,
                        color: ColorsAppGeneral.iconsGeneralColor,
                      ),
                    ),
                    const Text(
                      'Moments',
                    )
                  ],
                ),
                const Column(
                  children: [
                    Tab(
                        icon: Icon(
                      Icons.campaign,
                      color: ColorsAppGeneral.iconsGeneralColor,
                    )),
                    Text(
                      'Channels',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 600,
          child: TabBarView(controller: tabController2, children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Tela 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Tela 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class SelectedCategory {
  final String categoriaSelecionada;

  SelectedCategory({required this.categoriaSelecionada});

  factory SelectedCategory.fromJson(Map<String, dynamic> json) {
    return SelectedCategory(
      categoriaSelecionada: json['categoriaSelecionada'],
    );
  }
}

Widget noCatalog() {
  return const Column(
    children: [
      Text(
        'No Catalog',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
      ),
      Padding(
        padding: EdgeInsets.only(left: 70, right: 70),
        child: Text(
          'At the moment, we do not have a catalog available..',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ),
    ],
  );
}

Widget items() {
  return Padding(
    padding: const EdgeInsets.only(left: 12),
    child: Row(
      children: [
        Image.asset('lib/image/business.png'),
        const SizedBox(
          width: 7,
        ),
        const Text(
          'Items',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
