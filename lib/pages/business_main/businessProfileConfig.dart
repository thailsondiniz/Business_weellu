import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/pages/business_product_widgets/profile_user.dart';
import 'package:flutter_project_business/pages/business_product_widgets/categoryProductUser.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'business_home_page.dart';

class BusinessProfile extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const BusinessProfile(
      {super.key, required this.userId, required this.dadosUser});

  @override
  State<BusinessProfile> createState() => _BusinessState();
}

class _BusinessState extends State<BusinessProfile> {
  bool _switchValue = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController profileDescription = TextEditingController();
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //conexão / enviar descricao para api
  void enviarPostagem(String textoDescription) async {
    Uri url = Uri.parse('${ApiRota.baseApi}DescricaoNegocio');

    Map<String, dynamic> body = {
      'descriptionBusiness': profileDescription.text,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      print('Publicação salva com sucesso!');
      print(response.body);
    } else {
      print('Erro ao salvar a postagem. Status code: ${response.statusCode}');
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Business Configuration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF262626),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        ColorsAppGeneral.mainColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('lib/image/icon-home.png',
                          width: 30, height: 30),
                    )
                  : Image.asset('lib/image/icon-home.png',
                      width: 30, height: 30),
              label: 'Chat',
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
                                builder: (context) => BusinessMain(
                                      userId: widget.userId,
                                      dadosUser: widget.dadosUser,
                                    )),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessMain(
                                userId: widget.userId,
                                dadosUser: widget.dadosUser,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Image.asset('lib/image/business.png',
                            width: 30, height: 30),
                      ),
                    )
                  : Image.asset('lib/image/business.png',
                      width: 30, height: 30),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        ColorsAppGeneral.mainColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('lib/image/moments.png',
                          width: 30, height: 30),
                    )
                  : Image.asset('lib/image/moments.png', width: 30, height: 30),
              label: 'Moments',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        ColorsAppGeneral.mainColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('lib/image/grouup.png',
                          width: 30, height: 30),
                    )
                  : Image.asset('lib/image/grouup.png', width: 30, height: 30),
              label: 'Group',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 4
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        ColorsAppGeneral.mainColor,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('lib/image/profile.png',
                          width: 30, height: 30),
                    )
                  : Image.asset('lib/image/profile.png', width: 30, height: 30),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorsAppGeneral.mainColor,
          onTap: _onItemTapped,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsAppGeneral.mainColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.card_travel_outlined,
                          size: 30,
                          color: ColorsAppGeneral.mainColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Activate Business',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                SwitchTheme(
                  data: const SwitchThemeData(
                    trackOutlineColor: MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    trackColor: MaterialStatePropertyAll(
                      ColorsAppGeneral.mainColor,
                    ),
                  ),
                  child: Switch(
                    inactiveTrackColor: const Color.fromARGB(255, 78, 78, 78),
                    thumbColor: MaterialStateProperty.all(Colors.white),
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsAppGeneral.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              'lib/image/business.png',
                              color: ColorsAppGeneral.mainColor,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Description Business',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF444444),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: const Color(0xff3A3A3A),
                                  title: const Text(
                                    'Edit Description',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: TextField(
                                    controller: profileDescription,
                                    style: const TextStyle(color: Colors.white),
                                    // controller: _controller,
                                    decoration: InputDecoration(
                                      labelText: 'Business Description',
                                      contentPadding:
                                          const EdgeInsets.only(left: 20),
                                      labelStyle: const TextStyle(
                                        color: ColorsAppGeneral.mainColor,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (profileDescription.text.isEmpty) {
                                          print(
                                              'Por favor, preencha todos os campos.');
                                        } else {
                                          String textoDescription =
                                              profileDescription.text;
                                          enviarPostagem(textoDescription);
                                          Navigator.pop(
                                            context,
                                            'Save',
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsAppGeneral.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.sell_outlined,
                              size: 28,
                              color: ColorsAppGeneral.mainColor,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Category',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF444444),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Category(
                                        userId: widget.userId,
                                        dadosUser: widget.userId,
                                      )),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsAppGeneral.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.dashboard_customize_outlined,
                              size: 28,
                              color: ColorsAppGeneral.mainColor,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Catalog',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF444444),
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const ProfileUser()),
                            // );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
