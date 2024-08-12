import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import '../business_main/business_home_page.dart';

class Category extends StatefulWidget {
  final String userId;
  final String dadosUser;
  const Category({
    super.key,
    required this.userId,
    required this.dadosUser,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String selectedCategory = '';
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      selectedCategory = '';
      searchQuery = ''; // Redefine a pesquisa ao mudar de categoria
      filteredItems = items; // Mantém todas as categorias visíveis
    });
  }

  final List<String> items = [
    'Electronics',
    'Computers and accessories',
    'Smartphones and tablets',
    'Smart home devices',
    'Clothes',
  ];
  String searchQuery = '';
  List<String> filteredItems = [];
  void salvarCategoriaSelecionada(String categoriaSelecionada) async {
    final response = await http.post(
      Uri.parse('${ApiRota.baseApi}CategoriaSelecionada'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'categoriaSelecionada': categoriaSelecionada,
      }),
    );

    if (response.statusCode == 201) {
      print('Categoria selecionada salva com sucesso!');
    } else {
      print('Erro ao salvar categoria selecionada');
    }
  }

  List<bool> checkedItems = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff303030),
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff434343),
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xff303030),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xff46964A),
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
                        Color(0xff46964A),
                        BlendMode.srcIn,
                      ),
                      child: InkWell(
                        onTap: () {
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
                        Color(0xff46964A),
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
                        Color(0xff46964A),
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
                        Color(0xff46964A),
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
          selectedItemColor: const Color(0xff46964A),
          onTap: _onItemTapped,
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Category',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pesquisar Categoria'),
                                content: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value;
                                      filteredItems = items
                                          .where((item) => item
                                              .toLowerCase()
                                              .contains(
                                                  searchQuery.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Digite uma categoria...',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.search, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount:
                    searchQuery.isEmpty ? items.length : filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isChecked = false;
                  final category =
                      searchQuery.isEmpty ? items[index] : filteredItems[index];
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          side: const BorderSide(color: Colors.white),
                          value: checkedItems[index],
                          onChanged: (bool? value) {
                            setState(() {
                              checkedItems[index] = value!;
                              if (value == true) {
                                selectedCategory = category;
                              } else {
                                selectedCategory = '';
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedCategory.isNotEmpty) {
                      salvarCategoriaSelecionada(selectedCategory);
                    } else {
                      print('Nenhuma categoria selecionada.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
