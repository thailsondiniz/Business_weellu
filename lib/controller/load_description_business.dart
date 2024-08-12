import 'dart:convert';

import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;

class LoadDescriptionBusiness {
  List<dynamic> descricoes = [];
  void loadDescricaoBusiness() async {
    Uri url = Uri.parse('${ApiRota.baseApi}DescricaoNegocio');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return descricoes = jsonDecode(response.body);
      // print(descricoes);
    }
  }
}
