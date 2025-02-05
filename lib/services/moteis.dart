import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techtest_guia_motel/models/motel_model.dart';

class MotelServices {
  static Future<List<MotelModel>?> getAllMotels() async {
    var response = await http.get(
      Uri.http('https://www.jsonkeeper.com/b/1IXK'),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      return responseData.map((json) => MotelModel.fromJson(json)).toList();
    }

    return null;
  }
}
