import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techtest_guia_motel/models/motel_model.dart';

class MotelServices {
  static Future<List<MotelModel>> getAllMotels() async {
    final response =
        await http.get(Uri.parse('https://www.jsonkeeper.com/b/1IXK'));
    if (response.statusCode != 200) {
      throw Exception(
          'Falha ao carregar motéis: Código ${response.statusCode}');
    }
    final decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonData = json.decode(decodedBody);
    if (jsonData['sucesso'] != true) {
      throw Exception('Resposta da API indica falha');
    }
    final List<dynamic> moteis =
        List<Map<String, dynamic>>.from(jsonData['data']['moteis'] ?? []);
    return moteis.map((e) => MotelModel.fromJson(e)).toList();
  }
}
