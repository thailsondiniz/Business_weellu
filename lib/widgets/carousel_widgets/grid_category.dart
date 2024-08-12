import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/route/api_route.dart';

class GridCategory extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const GridCategory(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<GridCategory> createState() => _GridCategoryState();
}

class _GridCategoryState extends State<GridCategory> {
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
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 3 / 4.1,
        ),
        scrollDirection: Axis.vertical,
        itemCount: dados.length,
        itemBuilder: (context, index) {
          final reversedIndex = dados.length - 1 - index;
          final itemMap = dados[reversedIndex];
          final item = Item.fromJson(itemMap);
          return Column(
            children: [
              InkWell(
                onTap: () {
                  if (item.userId == widget.userId) {
                    print('são iguais ${widget.userId}, ${item.userId}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(
                            item: item,
                            userId: widget.userId,
                            dadosUser: widget.dadosUser),
                      ),
                    );
                  } else {
                    print('são diferentes');
                  }
                },
                child: Container(
                  width: 130,
                  height: 178,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              ColorsAppGeneral.borderChannelNotificationColor),
                      borderRadius: BorderRadius.circular(10),
                      color: ColorsAppGeneral.channelNotificationColor),
                  child: Stack(
                    children: [
                      SizedBox(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            '${ApiRota.baseApi}${item.imageUrl}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 110,
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
                                    child: Image.network(
                                      item.profilePhoto.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  item.nameBusiness.toString(),
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
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
                        left: 6,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                item.productName.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.start,
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
            ],
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_project_business/colors/colors.dart';
// import 'package:flutter_project_business/controller/load_destaques.dart';
// import 'package:flutter_project_business/model/item_class.dart';
// import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
// import 'package:flutter_project_business/route/api_route.dart';

// class GridCategory extends StatefulWidget {
//   const GridCategory({super.key});

//   @override
//   State<GridCategory> createState() => _GridCategoryState();
// }

// class _GridCategoryState extends State<GridCategory> {
//   List<dynamic> dados = [];
//   functionDestaque() async {
//     final destaqueCatalog = await LoadDestaques().Destaques();
//     setState(() {
//       dados = destaqueCatalog;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     functionDestaque();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: 0,
//           crossAxisSpacing: 0,
//           childAspectRatio: 3 / 4.2,
//         ),
//         scrollDirection: Axis.vertical,
//         itemCount: dados.length,
//         itemBuilder: (context, index) {
//           final reversedIndex = dados.length - 1 - index;
//           final itemMap = dados[reversedIndex];
//           final item = Item.fromJson(itemMap);
//           return Column(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Product(item: item),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
//                   child: Container(
//                     width: 130,
//                     height: 178,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: ColorsAppGeneral
//                                 .borderChannelNotificationColor),
//                         borderRadius: BorderRadius.circular(10),
//                         color: ColorsAppGeneral.channelNotificationColor),
//                     child: Stack(
//                       children: [
//                         SizedBox(
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10)),
//                             child: Image.network(
//                               '${ApiRota.baseApi}${item.imageUrl}',
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: 110,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           child: Container(
//                             width: 140,
//                             decoration: const BoxDecoration(
//                               color: Color.fromARGB(127, 31, 31, 31),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                               ),
//                             ),
//                             height: 33,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 5.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: Image.asset(
//                                       'lib/image/perfil.webp',
//                                       width: 25,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 const Text(
//                                   'Apple',
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 82,
//                           left: 70,
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 45,
//                                 height: 25,
//                                 decoration: BoxDecoration(
//                                   color: const Color.fromARGB(127, 31, 31, 31),
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                                 child: const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                       size: 20,
//                                     ),
//                                     Text(
//                                       '0,0',
//                                       style: TextStyle(color: Colors.white),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 111,
//                           left: 6,
//                           child: Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 2,
//                                 ),
//                                 Text(
//                                   item.productName.toString(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                   ),
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 Text(
//                                   item.price.toString(),
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 const SizedBox(
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         'Open',
//                                         style: TextStyle(
//                                             color: ColorsAppGeneral.mainColor,
//                                             fontSize: 12),
//                                       ),
//                                       SizedBox(
//                                         width: 3,
//                                       ),
//                                       Text(
//                                         '•',
//                                         style: TextStyle(
//                                           color: Color(0xFF7B7B7B),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 3,
//                                       ),
//                                       Text(
//                                         '5,3km',
//                                         style: TextStyle(
//                                             color: Color(0xFF7B7B7B),
//                                             fontSize: 12),
//                                         textAlign: TextAlign.start,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
