import 'dart:convert';
import 'package:flutter_project_business/model/item_class.dart';
import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;

class CatalogItems {
  List<Item> catalogItems = [];
  loadCatalogItems() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Item> items =
          decodedData.map((item) => Item.fromJson(item)).toList();
      // print(items);
      return catalogItems = items;
    }
  }
}
