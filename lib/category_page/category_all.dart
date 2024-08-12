import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/widgets/carousel_widgets/listview_category_all.dart';

class CategoryAll extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const CategoryAll({super.key, required this.userId, required this.dadosUser});

  @override
  State<CategoryAll> createState() => _CategoryAllState();
}

class _CategoryAllState extends State<CategoryAll> {
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
          Container(
            child: const ListViewCategory(),
          ),
        ],
      ),
    );
  }
}
