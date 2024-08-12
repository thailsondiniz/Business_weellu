import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/carousel_product.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/grid_category.dart';

class CategoryPageHome extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CategoryPageHome(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<CategoryPageHome> createState() => _CategoryPageHomeState();
}

class _CategoryPageHomeState extends State<CategoryPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
        title: const Text(
          'Recents',
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xff262626),
          ),
          child: BottomNavigatorBar(
            userId: widget.userId,
            dadosUser: widget.dadosUser,
          )),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recents Items',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridCategory(
            userId: widget.userId,
            dadosUser: widget.dadosUser,
          ),
        ],
      ),
    );
  }
}
