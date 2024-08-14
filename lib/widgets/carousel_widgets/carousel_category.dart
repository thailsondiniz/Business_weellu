import 'dart:convert';
import 'package:flutter_project_business/category_page/category_home.dart';
import 'package:flutter_project_business/category_page/category_specific.dart';
import 'package:flutter_project_business/model/category_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project_business/category_page/category_page_home.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';

class CarouselCategory extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CarouselCategory(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<CarouselCategory> createState() => _CarouselCategoryState();
}

class _CarouselCategoryState extends State<CarouselCategory> {
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
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff262626),
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
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'lib/category_images/categorie0.png',
                          color: ColorsAppGeneral.mainColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text('Recents', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dadosCategory.length,
                itemBuilder: (context, index) {
                  final ItemCategory item =
                      ItemCategory.fromJson(dadosCategory[index]);
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategorySpecific(
                                          userId: widget.userId,
                                          dadosUser: widget.dadosUser,
                                        )),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CategoryHome(
                              //         bankai: item.nome.toString()),
                              //   ),
                              // );
                            },
                            child: Icon(item.icon,
                                size: 35, color: Color(item.color as int)),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(item.nome.toString(),
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}


// SizedBox(
            //     height: 120,
            //     // color: Colors.cyan,
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 10, top: 10),
            //           child: Column(
            //             children: [
            //               Container(
            //                 height: 65,
            //                 width: 65,
            //                 decoration: BoxDecoration(
            //                   border:
            //                       Border.all(color: const Color(0xff515151)),
            //                   borderRadius: BorderRadius.circular(15),
            //                   color: const Color(0xff262626),
            //                 ),
            //                 child: InkWell(
            //                   onTap: () {},
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(18.0),
            //                     child: Image.asset(
            //                       fit: BoxFit.cover,
            //                       'lib/category_images/categorie0.png',
            //                       color: ColorsAppGeneral.mainColor,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 7,
            //               ),
            //               Text(categoriesMain[0],
            //                   style: const TextStyle(color: Colors.white)),
            //             ],
            //           ),
            //         ),
            //         Expanded(
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount:
            //                 8, // Reduzido para excluir o item 0, que agora é fixo
            //             itemBuilder: (context, index) {
            //               index +=
            //                   1; // Ajusta o índice para compensar o item fixo no início
            //               return Padding(
            //                 padding: const EdgeInsets.only(left: 10, top: 10),
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       height: 65,
            //                       width: 65,
            //                       decoration: BoxDecoration(
            //                         color: const Color(0xff262626),
            //                         border: Border.all(
            //                             color: ColorsAppGeneral
            //                                 .borderChannelNotificationColor),
            //                         borderRadius: BorderRadius.circular(50),
            //                       ),
            //                       child: InkWell(
            //                         onTap: () {},
            //                         child: Padding(
            //                           padding: const EdgeInsets.all(18.0),
            //                           child: Image.asset(
            //                             'lib/category_images/categorie$index.png',
            //                             fit: BoxFit.contain,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     const SizedBox(
            //                       height: 7,
            //                     ),
            //                     Text(categoriesMain[index],
            //                         style:
            //                             const TextStyle(color: Colors.white)),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     )),