import 'dart:convert';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_catalog/show_catalog_general.dart';
import 'package:flutter_project_business/pages/business_main/businessProfileConfig.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/widgets/show_interaction_widget_profile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileMainBusiness extends StatefulWidget {
  final String dadosUser;
  final String userId;
  const ProfileMainBusiness(
      {super.key, required this.dadosUser, required this.userId});

  @override
  State<ProfileMainBusiness> createState() => _ProfileUserStoreState();
}

class _ProfileUserStoreState extends State<ProfileMainBusiness> {
  Future<dynamic> buscarDadosUsuario() async {
    final url = Uri.parse('${ApiRota.baseApi}usuario/${widget.dadosUser}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados do usuário');
    }
  }

  bool isVisibility = false;

  List<dynamic> descricoes = [];
  void loadDescricaoBusiness() async {
    Uri url = Uri.parse('${ApiRota.baseApi}DescricaoNegocio');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        descricoes = jsonDecode(response.body);
        // print(descricoes);
      });
    }
  }

  List<Item> catalogItems = [];
  loadCatalogItems() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      String loggedInUserId = widget.userId;

      final List<Item> filteredItems = decodedData
          .map((item) => Item.fromJson(item))
          .where((item) => item.userId == loggedInUserId)
          .toList();

      setState(() {
        catalogItems = filteredItems;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCatalogItems();
    loadDescricaoBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: buscarDadosUsuario(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao buscar dados do usuário'));
        } else {
          var usuario = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsAppGeneral.appBarColor,
              title: const Text(
                'Business',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessProfile(
                                dadosUser: widget.userId,
                                userId: widget.userId,
                              )),
                    );
                  },
                  icon: Icon(
                    PhosphorIcons.gear(
                      PhosphorIconsStyle.regular,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: const Color(0xff262626),
                ),
                child: BottomNavigatorBar(
                  userId: widget.userId,
                  dadosUser: widget.dadosUser,
                )),
            backgroundColor: ColorsAppGeneral.backgroundColor,
            body: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        const Positioned(
                          child: SizedBox(
                            height: 165,
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            usuario['coverPhoto'],
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 85,
                          // left: 170,
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                usuario['profilePhoto'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          usuario['nameUser'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${usuario['categoryBusiness']}',
                          style: const TextStyle(
                              color: ColorsAppGeneral.descriptionColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Open now',
                                style: TextStyle(
                                    color: ColorsAppGeneral.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '•',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '4,5Km',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 370,
                          child: descricoes.isNotEmpty
                              ? Text(
                                  descricoes.last
                                          .containsKey('descriptionBusiness')
                                      ? descricoes.last['descriptionBusiness']
                                      : 'No description available',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: ColorsAppGeneral.descriptionColor,
                                    fontSize: 11,
                                  ),
                                )
                              : const Text(
                                  'No description available',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorsAppGeneral.descriptionColor,
                                    fontSize: 11,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: 4.5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_rounded,
                                color: Color(0xffFFB341),
                              ),
                              unratedColor: ColorsAppGeneral
                                  .borderChannelNotificationColor,
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            const Text(
                              '4,5',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              '1,8k reviews',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isVisibility = !isVisibility;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 3, bottom: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ColorsAppGeneral.mainColor)),
                                child: Text(
                                  isVisibility == true
                                      ? 'View Less'
                                      : 'View More',
                                  style: const TextStyle(
                                      color: ColorsAppGeneral.mainColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //
                        const SizedBox(
                          height: 25,
                        ),
                        ShowInteractionWidgetProfile(
                          nameBusiness: widget.dadosUser,
                          dadosUser: widget.dadosUser,
                          userId: widget.userId,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Catalog',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShowCatalogGeneral(
                                                dadosUser: widget.dadosUser,
                                                userId: widget.userId,
                                              )),
                                    );
                                  },
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                              const Icon(
                                size: 17,
                                Icons.arrow_forward_ios_outlined,
                                color: ColorsAppGeneral.descriptionColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
                      child: SizedBox(
                        height: 500,
                        child: catalogItems.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 2 / 2.5,
                                ),
                                padding: const EdgeInsets.all(
                                    8.0), // padding around the grid
                                itemCount: catalogItems.isNotEmpty
                                    ? catalogItems.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  final reversedIndex =
                                      catalogItems.length - 1 - index;
                                  final item = catalogItems[reversedIndex];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Product(
                                                  item: item,
                                                  userId: widget.userId,
                                                  dadosUser: widget.dadosUser,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 0.8,
                                            color: ColorsAppGeneral
                                                .borderChannelNotificationColor),
                                        color: ColorsAppGeneral
                                            .channelNotificationColor,
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5),
                                                      topRight:
                                                          Radius.circular(5)),
                                              child: Image.network(
                                                width: 200,
                                                height: 150,
                                                '${ApiRota.baseApi}${item.imageUrl}',
                                                fit: BoxFit.cover,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 15, top: 5),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  // color: Colors.cyan,
                                                  width: 210,
                                                  child: Text(
                                                    item.productName.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  // color: Colors.cyan,
                                                  width: 250,
                                                  child: Text(
                                                    item.description.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: ColorsAppGeneral
                                                          .descriptionColor,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                  // color: Colors.cyan,
                                                  width: 190,
                                                  child: Text(
                                                    item.price.toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      color: ColorsAppGeneral
                                                          .mainColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
