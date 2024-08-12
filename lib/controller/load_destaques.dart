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


  // void Destaques() async {
  //   Uri url = Uri.parse('http://10.0.0.122:3000/itens');
  //   http.Response response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       dados = jsonDecode(response.body);
  //       print(dados);
  //     });
  //   }
  // }