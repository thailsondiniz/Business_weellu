import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_business/category_page/category_home.dart';
import 'package:flutter_project_business/category_page/category_page_home.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/category_class.dart';
import 'package:flutter_project_business/model/sub_category.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;

class CarouselSpecificCategory extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CarouselSpecificCategory(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<CarouselSpecificCategory> createState() =>
      _CarouselSpecificCategoryState();
}

class _CarouselSpecificCategoryState extends State<CarouselSpecificCategory> {
  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  List<dynamic> dadosCategory = [];

  void categoria() async {
    Uri url = Uri.parse('${ApiRota.baseApi}categorias');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dadosCategory = jsonDecode(response.body);
        print('Dados da categoria:');
      });
    } else {
      print(
          'Falha ao carregar dados da categoria. Código de status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    functionDestaque();
    categoria();
  }

  @override
  Widget build(BuildContext context) {
    var categoriaEspecifica = dadosCategory.firstWhere(
      (categoria) => categoria['id'] == '1',
      orElse: () => null,
    );
    List<dynamic> subCategorias =
        categoriaEspecifica != null ? categoriaEspecifica['subCategoria'] : [];

    return SizedBox(
        height: 120,
        // color: Colors.cyan,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff515151)),
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffF54D18),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPageHome(
                              userId: widget.userId,
                              dadosUser: widget.dadosUser,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'lib/category_images/categorie1.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text('All', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategorias
                  .length, // Assume que isto é uma lista de SubCategoryItem
              itemBuilder: (context, index) {
                SubCategoryItem itemSub =
                    SubCategoryItem.fromJson(subCategorias[index]);

                return Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: ColorsAppGeneral.bottomBarColor,
                          border: Border.all(
                              color: ColorsAppGeneral
                                  .borderChannelNotificationColor),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(itemSub.iconSub,
                            size: 35, color: itemSub.color),
                      ),
                      const SizedBox(height: 7),
                      SizedBox(
                        width: 60,
                        child: Text(
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          itemSub.nome ?? 'no name',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ],
        ));
  }
}
