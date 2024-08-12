import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_business/colors/colors.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputHideItem.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputPriceProduct.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputProductDescription.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/inputProductName.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/snackBarAlertInsertImage.dart';
import 'package:flutter_project_business/pages/business_catalog/CreateCatalogInputsWidgets/snackBarAlertInsertText.dart';
import 'package:flutter_project_business/pages/business_product_widgets/edit_product_page.dart';
import 'package:flutter_project_business/profile/profile_user_store.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../business_product_widgets/profile_user.dart';

class CreateCatalog extends StatefulWidget {
  final String userId;
  final String dadosUser;
  final String nameBusiness;
  const CreateCatalog(
      {super.key,
      required this.nameBusiness,
      required this.userId,
      required this.dadosUser});

  @override
  State<CreateCatalog> createState() => _CreateCatalogState();
}

class _CreateCatalogState extends State<CreateCatalog> {
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
  final TextEditingController _nameProductTexto = TextEditingController();
  final TextEditingController _valuePrice = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  List<Widget> imagePreviews = [];

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
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    double parsedValue = double.tryParse(cleanedValue)! / 100;
    return _currencyFormat.format(parsedValue);
  }

  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
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
                onPressed: () {
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
                    if (selectedImage == null) {
                      print('Selecione uma imagem antes de publicar.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        snackBarAlertInsertImage() as SnackBar,
                      );
                    } else {
                      final request = http.MultipartRequest(
                        'POST',
                        Uri.parse('${ApiRota.baseApi}itens'),
                      );
                      request.fields['nameBusiness'] = widget.nameBusiness;
                      request.fields['productName'] = _nameProductTexto.text;
                      request.fields['price'] = _valuePrice.text;
                      request.fields['description'] = _description.text;
                      request.fields['brand'] = _brand.text;
                      request.fields['model'] = _model.text;
                      request.fields['color'] = _color.text;
                      request.fields['category'] = selectedItem;

                      request.files.add(
                        http.MultipartFile(
                          'image',
                          File(selectedImage!.path).readAsBytes().asStream(),
                          File(selectedImage!.path).lengthSync(),
                          filename: selectedImage?.path.split('/').last,
                          contentType: MediaType('image', 'jpeg'),
                        ),
                      );

                      final client = http.Client();
                      client.send(request).then(
                        (response) {
                          client.close();
                          if (response.statusCode == 201) {
                            print('Publicação salva com sucesso!');
                            print(
                              response.stream.bytesToString(),
                            );
                            _nameProductTexto.clear();
                            _valuePrice.clear();
                            _description.clear();
                            _brand.clear();
                            _model.clear();
                            _color.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileUserStore(
                                  dadosUser: widget.dadosUser,
                                  userId: widget.userId,
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1500),
                                backgroundColor: ColorsAppGeneral.mainColor,
                                content:
                                    Text('Produto cadastrado com sucesso!'),
                              ),
                            );
                          } else {
                            print(
                                'Erro ao salvar a postagem. Status code: ${response.statusCode}');
                          }
                        },
                      ).catchError(
                        (error) {
                          client.close();
                          print('Erro ao enviar a imagem: $error');
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsAppGeneral.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Publish',
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
                  // color: Colors.cyan,
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
                                      left: 15, top: 3, right: 15),
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
                                  padding: EdgeInsets.only(right: 0),
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

// Widget inputController(nameProduct, nameDescription, controller) {
//   final formKey = GlobalKey<FormState>();
//   return Form(
//     key: formKey,
//     child:
//   );
// }

