import 'package:flutter/material.dart';
import 'package:flutter_project_business/category_widget/category_tabBar.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/listview_category_all.dart';

class CategorySpecific extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CategorySpecific(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<CategorySpecific> createState() => _CategorySpecificState();
}

class _CategorySpecificState extends State<CategorySpecific> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
        title: const Text(
          'Categories',
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
          // Container(
          //   child: const ListViewCategory(),
          // ),
          TabBarCategory(
            userId: widget.userId,
            dadosUser: widget.dadosUser,
          ),
        ],
      ),
    );
  }
}
