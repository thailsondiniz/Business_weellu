import 'package:flutter_project_business/route/api_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetUser {
  List<dynamic> dataUser = [];
  usuarios() async {
    Uri url = Uri.parse('${ApiRota.baseApi}usuarios');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return dataUser = jsonDecode(response.body);
    }
  }
}
