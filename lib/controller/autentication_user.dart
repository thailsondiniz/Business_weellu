import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project_business/route/api_route.dart';

class AutenticationUser {
  Future<Map<String, dynamic>> verificarUsuario(String nomeUsuario) async {
    final url = Uri.parse('${ApiRota.baseApi}usuarios');
    Map<String, dynamic> resultado = {'autenticado': false, 'userId': null};
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> usuarios = json.decode(response.body);

        var usuarioEncontrado = usuarios.firstWhere(
            (usuario) => usuario['nameUser'] == nomeUsuario,
            orElse: () => null);
        if (usuarioEncontrado != null) {
          resultado['autenticado'] = true;
          resultado['userId'] = usuarioEncontrado['_id'];
        }
      }
    } catch (e) {
      print(e);
    }
    return resultado;
  }
}


// final List<dynamic> idUsuario = json.decode(response.body);
// final idUsuarioData =
//             idUsuario.any((usuario) => usuario['userId'] == nomeUsuario);