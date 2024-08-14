import 'dart:convert';
import 'package:flutter_project_business/model/category_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project_business/category_page/category_page_home.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';

class ListViewCategory extends StatefulWidget {
  const ListViewCategory({super.key});

  @override
  State<ListViewCategory> createState() => _ListViewCategoryState();
}

class _ListViewCategoryState extends State<ListViewCategory> {
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
    // TODO: implement initState
    super.initState();
    categoria();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: dadosCategory.length,
              itemBuilder: (context, index) {
                final ItemCategory item =
                    ItemCategory.fromJson(dadosCategory[index]);
                return Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorsAppGeneral.channelNotificationColor,
                      border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xff262626),
                            border: Border.all(
                                color: ColorsAppGeneral
                                    .borderChannelNotificationColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {},
                            child: Icon(item.icon,
                                size: 35, color: Color(item.color as int)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.nome.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                            const Row(
                              children: [
                                Text('Profiles: 14',
                                    style: TextStyle(
                                        color:
                                            ColorsAppGeneral.descriptionColor,
                                        fontSize: 12)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('•',
                                    style: TextStyle(
                                        color:
                                            ColorsAppGeneral.descriptionColor,
                                        fontSize: 17)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Products: 120',
                                    style: TextStyle(
                                        color:
                                            ColorsAppGeneral.descriptionColor,
                                        fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
