import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/getUser.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/carousel_category.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/carousel_specific_category.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/grid_category.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TabBarCategory extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const TabBarCategory(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<TabBarCategory> createState() => _TabBarCategoryState();
}

class _TabBarCategoryState extends State<TabBarCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController2;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    functionGetUsers();
    functionDestaque();
    tabController2 = TabController(length: 2, vsync: this);
  }

  List<dynamic> dataUser = [];
  functionGetUsers() async {
    final listUsers = await GetUser().usuarios();
    setState(() {
      dataUser = listUsers;
    });
  }

  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CarouselSpecificCategory(
          userId: widget.userId,
          dadosUser: widget.userId,
        ),
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
                        icon: Icon(
                      size: 30,
                      PhosphorIcons.usersThree(PhosphorIconsStyle.regular),
                    )),
                    const Text(
                      'Profiles',
                    )
                  ],
                ),
                const Column(
                  children: [
                    Tab(
                        icon: Icon(
                      size: 30,
                      Icons.shopping_bag_outlined,
                    )),
                    Text(
                      'Product',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 500,
          child: TabBarView(controller: tabController2, children: [
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                PhosphorIcons.mapPin(
                                    PhosphorIconsStyle.regular),
                                color: ColorsAppGeneral.descriptionColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Av. B - Cidade Jardim, Lt. 23',
                                style: TextStyle(
                                  color: ColorsAppGeneral.descriptionColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${dataUser.length} Profiles was find',
                                style: const TextStyle(
                                    color: Color(0xffB0B0B0), fontSize: 11),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  PhosphorIcons.funnelSimple(
                                      PhosphorIconsStyle.regular),
                                ),
                                color: ColorsAppGeneral.descriptionColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          childAspectRatio: 2 / 2.45,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: dataUser.length,
                        itemBuilder: (context, index) {
                          final reversedIndex = dataUser.length - 1 - index;
                          final itemMap = dataUser[reversedIndex];
                          final item = Item.fromJson(itemMap);
                          return Column(
                            children: [
                              Container(
                                width: 200,
                                height: 238,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: ColorsAppGeneral
                                            .borderChannelNotificationColor),
                                    color: ColorsAppGeneral
                                        .channelNotificationColor),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5)),
                                            child: Container(
                                              child: Image.network(
                                                item.coverPhoto.toString(),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 85,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 55,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  item.profilePhoto.toString(),
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          item.nameBusiness.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Open Now',
                                              style: TextStyle(
                                                  color: ColorsAppGeneral
                                                      .mainColor),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              '•',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              '4,5Km',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 92,
                                          height: 28,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape:
                                                  const ContinuousRectangleBorder(
                                                      side: BorderSide.none),
                                              backgroundColor:
                                                  Colors.transparent,
                                              side: const BorderSide(
                                                color:
                                                    ColorsAppGeneral.mainColor,
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'View Catalog',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: ColorsAppGeneral
                                                      .mainColor),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        SizedBox(
                                          width: 80,
                                          height: 28,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              shape:
                                                  const ContinuousRectangleBorder(
                                                      side: BorderSide.none),
                                              backgroundColor:
                                                  Colors.transparent,
                                              side: const BorderSide(
                                                color:
                                                    ColorsAppGeneral.mainColor,
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              'Follow',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: ColorsAppGeneral
                                                      .mainColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingBarIndicator(
                                          rating: 4.5,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xffFFB341),
                                          ),
                                          unratedColor: ColorsAppGeneral
                                              .borderChannelNotificationColor,
                                          itemCount: 5,
                                          itemSize: 13.0,
                                          direction: Axis.horizontal,
                                        ),
                                        const Text(
                                          '4,5',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text(
                                          '10,7k reviews',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3, top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                            color: ColorsAppGeneral.descriptionColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Av. B - Cidade Jardim, Lt. 23',
                            style: TextStyle(
                              color: ColorsAppGeneral.descriptionColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${dados.length} Profiles was find',
                            style: const TextStyle(
                                color: Color(0xffB0B0B0), fontSize: 11),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              PhosphorIcons.funnelSimple(
                                  PhosphorIconsStyle.regular),
                            ),
                            color: ColorsAppGeneral.descriptionColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GridCategory(
                  userId: widget.userId,
                  dadosUser: widget.dadosUser,
                ),
              ],
            )
          ]),
        ),
      ],
    );
  }
}
