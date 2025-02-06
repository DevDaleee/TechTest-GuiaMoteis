import 'package:techtest_guia_motel/models/suite_model.dart';

class MotelModel {
  String? name;
  String? imageUrl;
  String? neighborhood;
  double? distance;
  int? favorites;
  List<SuiteModel>? suites;

  MotelModel({
    this.name,
    this.imageUrl,
    this.neighborhood,
    this.distance,
    this.favorites,
    this.suites,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      name: json['fantasia'] as String?,
      imageUrl: json['logo'] as String?,
      neighborhood: json['bairro'] as String?,
      distance: (json['distancia'] as num?)?.toDouble(),
      favorites: json['qtdFavoritos'] as int?,
      suites: (json['suites'] as List<dynamic>?)
          ?.map((e) => SuiteModel.fromJson(e))
          .toList(),
    );
  }
}
