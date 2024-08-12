import 'dart:convert';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;

class LoadCategoryItems {
  List<dynamic> data = [];
  loadCategoryItems() async {
    Uri url = Uri.parse('${ApiRota.baseApi}CategoriaSelecionada');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return data = jsonDecode(response.body);
    }
  }
}


  // void loadCategoryItems() async {
  //   Uri url = Uri.parse('http://10.0.0.122:3000/CategoriaSelecionada');
  //   http.Response response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = jsonDecode(response.body);
  //       // print(data);
  //     });
  //   }
  // }