import 'package:flutter/material.dart';
import 'package:flutter_project_business/pages/business_main/business_home_page.dart';
import 'package:flutter_project_business/pages/business_main/businessProfileConfig.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'dart:ui';
import 'package:flutter_project_business/pages/business_product_widgets/profile_user.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavigatorBar extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const BottomNavigatorBar(
      {super.key, required this.userId, required this.dadosUser});

  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _selectedIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _selectedIndex == 0
              ? ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    ColorsAppGeneral.mainColor,
                    BlendMode.srcIn,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessMain(
                            userId: widget.userId,
                            dadosUser: widget.dadosUser,
                          ),
                        ),
                      );
                    },
                    child: Image.asset('lib/image/business.png',
                        width: 30, height: 30),
                  ),
                )
              : Image.asset('lib/image/business.png', width: 30, height: 30),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    ColorsAppGeneral.mainColor,
                    BlendMode.srcIn,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileUser(
                            userId: widget.userId,
                            dadosUser: widget.dadosUser,
                          ),
                        ),
                      );
                    },
                    child: Image.asset('lib/image/profile.png',
                        width: 30, height: 30),
                  ),
                )
              : Image.asset('lib/image/profile.png', width: 30, height: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorsAppGeneral.mainColor,
      onTap: onTabTapped,
    );
  }
}
