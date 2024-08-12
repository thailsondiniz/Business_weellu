import 'dart:convert';
import 'package:flutter_project_business/pages/business_catalog/show_catalog_general.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:flutter_project_business/widgets/bottom_navigator_bar_widget/bottomnavigatorbar.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/widgets/tab_bar_profile.dart';

class ProfileUser extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const ProfileUser({super.key, required this.userId, required this.dadosUser});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> buscarDadosUsuario() async {
    final url = Uri.parse('${ApiRota.baseApi}usuario/${widget.dadosUser}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados do usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buscarDadosUsuario(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao buscar dados do usuário'));
          } else {
            var usuario = snapshot.data;
            return Scaffold(
              backgroundColor: ColorsAppGeneral.backgroundColor,
              appBar: AppBar(
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 7),
                    child: Icon(
                      Icons.settings_outlined,
                    ),
                  ),
                ],
                title: const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: ColorsAppGeneral.appBarColor,
                centerTitle: true,
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: const Color(0xFF262626),
                ),
                child: BottomNavigatorBar(
                  userId: widget.userId,
                  dadosUser: widget.userId,
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(),
                child: FloatingActionButton(
                  backgroundColor: ColorsAppGeneral.mainColor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const CreateCatalog()),
                    // );
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              usuario['profilePhoto'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          usuario['nameUser'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1k Followers',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '2,5k Following',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowCatalogGeneral(
                                          dadosUser: widget.dadosUser,
                                          userId: widget.userId,
                                        )),
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 3, bottom: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorsAppGeneral.mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text('Business',
                                    style: TextStyle(
                                        color: ColorsAppGeneral.mainColor))),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                    const TabBarProfile()
                  ],
                ),
              ),
            );
          }
        });
  }
}

//  descricoes.isEmpty
//                     ? const Text(
//                         'No description available',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                       )
//                     : SizedBox(
//                         width: 360,
//                         child: Text(
//                           descricoes.last['descriptionBusiness'],
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               color: ColorsAppGeneral.iconsGeneralColor,
//                               fontSize: 12),
//                         ),
//                       ),
  // List<dynamic> data = [];
  // functionCategoryItems() async {
  //   final categoryItems = await LoadCategoryItems().loadCategoryItems();
  //   setState(() {
  //     data = categoryItems;
  //   });
  // }

  // List<dynamic> descricoes = [];
  // void loadDescricaoBusiness() async {
  //   Uri url = Uri.parse('${ApiRota.baseApi}DescricaoNegocio');
  //   http.Response response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       descricoes = jsonDecode(response.body);
  //       // print(descricoes);
  //     });
  //   }
  // }