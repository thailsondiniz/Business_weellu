import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_project_business/category_page/category_all.dart';
import 'package:flutter_project_business/controller/getUser.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/carousel_category.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/carousel_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/listview_profiles_business.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BusinessMain extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const BusinessMain(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<BusinessMain> createState() => _BusinessMainState();
}

class _BusinessMainState extends State<BusinessMain> {
  late PageController _pageController;
  int activePage = 0;

  List<String> images = [
    "https://img.freepik.com/free-vector/creative-sales-banner-with-abstract-details_52683-67038.jpg",
    "https://www.designi.com.br/images/preview/11343760.jpg",
    "https://i.pinimg.com/1200x/d4/e5/c8/d4e5c8a7fd70dc54bc2fcf134fb5dbad.jpg",
    "https://i.ytimg.com/vi/DEFUm7BcT_A/maxresdefault.jpg"
  ];

  List<dynamic> dados = [];
  functionDestaque() async {
    final destaqueCatalog = await LoadDestaques().Destaques();
    setState(() {
      dados = destaqueCatalog;
    });
  }

  List<dynamic> dataUser = [];
  functionGetUsers() async {
    final listUsers = await GetUser().usuarios();
    setState(() {
      dataUser = listUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: activePage);
    startAutoPlay();
    functionDestaque();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void startAutoPlay() {
    const Duration autoPlayDuration = Duration(seconds: 3);
    Timer.periodic(autoPlayDuration, (_) {
      if (activePage < images.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<Widget> indicators(imagesLength) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        return Container(
          margin: const EdgeInsets.only(top: 5, left: 3, right: 3),
          width: 8,
          height: 10,
          decoration: BoxDecoration(
              color: activePage == index
                  ? const Color(0xffDADADA)
                  : const Color(0xff505050),
              shape: BoxShape.circle),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text(
          'Business',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xff262626),
          ),
          child: BottomNavigatorBar(
            userId: widget.userId,
            dadosUser: widget.dadosUser,
          )),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: SizedBox(
                height: 150,
                child: PageView.builder(
                  itemCount: images.length,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      color: Colors.grey[0],
                      margin: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            images[pagePosition],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(images.length),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryAll(
                                  userId: widget.userId,
                                  dadosUser: widget.dadosUser,
                                )),
                      );
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            CarouselCategory(
              userId: widget.userId,
              dadosUser: widget.dadosUser,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Hightlights',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                CarouselProduct(
                  userId: widget.userId,
                  dadosUser: widget.dadosUser,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Near yo you',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_list,
                        color: ColorsAppGeneral.mainColor,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                        color: const Color(0xff009d6d),
                      ),
                      const Text(
                        'Ave Times squared, 3015',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    'View All',
                    style: TextStyle(color: Color(0xffB0B0B0), fontSize: 11),
                  ),
                ],
              ),
            ),
            ListViewProfilesBusiness(
              dadosUser: widget.dadosUser,
              userId: widget.userId,
            ),
          ],
        ),
      ),
    );
  }
}
