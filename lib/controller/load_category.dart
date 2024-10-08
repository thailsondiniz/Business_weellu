import 'package:flutter_project_business/model/category_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadCategory {
  List<ItemCategory> dadosCategory = [];
  Category() async {
    Uri url = Uri.parse('${ApiRota.baseApi}categorias');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<ItemCategory> items =
          decodedData.map((item) => ItemCategory.fromJson(item)).toList();
      return dadosCategory = items;
    }
  }
}
