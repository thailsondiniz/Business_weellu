import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadDestaques {
  List<dynamic> dados = [];
  Destaques() async {
    Uri url = Uri.parse('${ApiRota.baseApi}itens');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return dados = jsonDecode(response.body);
    }
  }
}
