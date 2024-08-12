import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/category_page/category_home.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/controller/getUser.dart';
import 'package:flutter_project_business/controller/load_destaques.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/profile/profile_main_business.dart';
import 'package:flutter_project_business/profile/profile_user_store.dart';
import 'package:flutter_project_business/route/api_route.dart';

class ListViewProfilesBusiness extends StatefulWidget {
  final String dadosUser;
  final String userId;
  const ListViewProfilesBusiness(
      {super.key, required this.dadosUser, required this.userId});

  @override
  State<ListViewProfilesBusiness> createState() =>
      _ListViewProfilesBusinessState();
}

class _ListViewProfilesBusinessState extends State<ListViewProfilesBusiness> {
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

  bool isFollowing = false;
  @override
  void initState() {
    super.initState();
    functionDestaque();
    functionGetUsers();
    // print(dataUser);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: dataUser.length,
        itemBuilder: (context, index) {
          final reversedIndex = dataUser.length - 1 - index;
          final itemMap = dataUser[reversedIndex];
          final item = Item.fromJson(itemMap);
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileMainBusiness(
                              dadosUser: widget.dadosUser,
                              userId: widget.userId,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[0],
                                borderRadius: BorderRadius.circular(50)),
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  item.profilePhoto.toString(),
                                ),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.grey[300],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nameBusiness.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  item.categoryBusiness.toString(),
                                  style:
                                      const TextStyle(color: Color(0xffC5C5C5)),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Open',
                                      style:
                                          TextStyle(color: Color(0xff009d6d)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '•',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '3.2 km',
                                      style:
                                          TextStyle(color: Color(0xffC5C5C5)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Icon(Icons.star,
                                        color: Color(0xffFFB341), size: 20),
                                    Text(
                                      '4,5',
                                      style:
                                          TextStyle(color: Color(0xffC5C5C5)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFollowing = !isFollowing;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 3),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isFollowing
                                    ? Colors.red
                                    : ColorsAppGeneral.mainColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            isFollowing ? 'Unfollow' : 'Follow',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
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
