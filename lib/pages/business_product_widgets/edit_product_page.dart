import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputHideItem.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputPriceProduct.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputProductDescription.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputProductName.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/snackBarAlertInsertText.dart';
import 'package:flutter_project_business/pages/business_product_widgets/product_page.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProductPage extends StatefulWidget {
  final Item item;
  final String userId;
  final String dadosUser;
  const EditProductPage(
      {super.key,
      required this.item,
      required this.userId,
      required this.dadosUser});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  String selectedItem = 'No category';
  List<String> items = [
    'No category',
    'Food',
    'Home',
    'Vehicles',
    'Electronics',
    'Clothes',
    'Travel',
    'Sports',
    'Health'
  ];
  bool status = false;
  late final TextEditingController _nameProductTexto =
      TextEditingController(text: widget.item.productName);
  late final TextEditingController _valuePrice =
      TextEditingController(text: widget.item.price);
  late final TextEditingController _description =
      TextEditingController(text: widget.item.description);
  late final TextEditingController _brand =
      TextEditingController(text: widget.item.brand);
  late final TextEditingController _model =
      TextEditingController(text: widget.item.model);
  late final TextEditingController _color =
      TextEditingController(text: widget.item.color);
  late final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  List<Widget> imagePreviews = [];
  //conexão
  // void enviarPostagem(
  //     String productName, String price, String description) async {
  //   // Uri url = Uri.parse('http://10.0.0.122:3000/itens');
  // }

  File? selectedImage;
  bool showImagePreview = false;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        final newImagePreview = Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xff3A3A3A),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Image.file(
            File(pickedFile.path),
            fit: BoxFit.cover,
          ),
        );
        imagePreviews.add(newImagePreview);
        imagePreviews.remove(newImagePreview);
        imagePreviews.insert(0, newImagePreview);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      imagePreviews.removeAt(index);
    });
  }

  String formatCurrency(String value) {
    // Remova qualquer formatação monetária do valor atual
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    double parsedValue = double.tryParse(cleanedValue)! /
        100; // Divida por 100 para considerar os centavos
    return _currencyFormat.format(parsedValue);
  }

  Future<void> updateDate(
      String itemId,
      String newProductName,
      String newPrice,
      String newDescription,
      String newBrand,
      String newModel,
      String newColor) async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens/$itemId');

    var request = http.MultipartRequest('PUT', url)
      ..fields['productName'] = _nameProductTexto.text
      ..fields['price'] = _valuePrice.text
      ..fields['description'] = _description.text
      ..fields['brand'] = _brand.text
      ..fields['model'] = _model.text
      ..fields['color'] = _color.text
      ..fields['category'] = selectedItem;

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'image', selectedImage!.path,
          contentType: MediaType('image', 'jpeg')));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Sucesso na atualização do item com imagem");
    } else {
      print("Erro na atualização: ${response.statusCode}");
    }
  }

  List<dynamic> dados = [];
  void Destaques() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dados = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Destaques();
    final existingImagePreview = Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xff3A3A3A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Image.network(
        '${ApiRota.baseApi}${widget.item.imageUrl}',
        fit: BoxFit.cover,
      ),
    );
    imagePreviews.add(existingImagePreview);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAppGeneral.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Create Catalog',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsAppGeneral.appBarColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        color: ColorsAppGeneral.appBarColor,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 120.0, vertical: 10.0),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await updateDate(
                      widget.item.itemId.toString(),
                      _nameProductTexto.text,
                      _valuePrice.text,
                      _description.text,
                      _brand.text,
                      _model.text,
                      _color.text,
                    );

                    if (_nameProductTexto.text.isEmpty ||
                            _valuePrice.text.isEmpty ||
                            _description.text.isEmpty
                        // _brand.text.isEmpty ||
                        // _model.text.isEmpty ||
                        // _color.text.isEmpty
                        ) {
                      print('Por favor, preencha todos os campos.');

                      if (_formKey.currentState!.validate()) {
                      } else if (_nameProductTexto.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarAlert() as SnackBar,
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: ColorsAppGeneral.mainColor,
                            content: Text('Dados atualizados com sucesso!')),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Product(
                              item: widget.item,
                              userId: widget.userId,
                              dadosUser: widget.dadosUser),
                        ),
                      );
                    }
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            'Erro ao atualizar os dados: $error',
                          )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ColorsAppGeneral.mainColor, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagePreviews.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          width: 110,
                          decoration: BoxDecoration(
                            color:
                                ColorsAppGeneral.borderChannelNotificationColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                            onPressed: _pickImage,
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                            ),
                            child: imagePreviews[index - 1],
                          ),
                          Positioned(
                            top: -10,
                            left: 90,
                            child: IconButton(
                              onPressed: () {
                                _removeImage(index - 1);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const HideItem(),
                    productName(_nameProductTexto, 'Product Name'),
                    productDescription(_description, 'Product Description'),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 200, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    ColorsAppGeneral.channelNotificationColor,
                                border: Border.all(
                                    color: ColorsAppGeneral
                                        .borderChannelNotificationColor)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<dynamic>(
                                dropdownColor: const Color(0xff424242),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20, top: 3, right: 10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                value: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value.toString();
                                  });
                                },
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.expand_more,
                                    color: ColorsAppGeneral.iconsGeneralColor,
                                  ),
                                ),
                                isExpanded: true,
                                elevation: 16,
                                items: items.map((item) {
                                  return DropdownMenuItem<dynamic>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    price(_valuePrice, "R\$ 00,00"),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Product Highlights',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    inputHighlights("Product Brand", _brand),
                    inputHighlights("Product Model", _model),
                    inputHighlights("Product Color", _color),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputController(nameProduct, nameDescription, controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameProduct,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsAppGeneral.channelNotificationColor,
              border: Border.all(
                  color: ColorsAppGeneral.borderChannelNotificationColor)),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              hintText: nameDescription,
              hintStyle:
                  const TextStyle(color: Color(0xffAAAAAA), fontSize: 14),
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              labelStyle: const TextStyle(
                color: ColorsAppGeneral.mainColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget inputHighlights(nameDescription, controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorsAppGeneral.channelNotificationColor,
              border: Border.all(
                  color: ColorsAppGeneral.borderChannelNotificationColor)),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              hintText: nameDescription,
              hintStyle:
                  const TextStyle(color: Color(0xffAAAAAA), fontSize: 14),
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              labelStyle: const TextStyle(color: ColorsAppGeneral.mainColor),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
