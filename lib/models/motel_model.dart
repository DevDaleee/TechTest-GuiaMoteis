import 'package:techtest_guia_motel/models/suite_model.dart';

class MotelModel {
  String? name;
  String? logoUrl;
  String? neighborhood;
  double? distance;
  int? favorites;
  List<SuiteModel>? suites;
  int? reviews;
  double? rate;

  MotelModel({
    this.name,
    this.logoUrl,
    this.neighborhood,
    this.distance,
    this.favorites,
    this.suites,
    this.reviews,
    this.rate,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      name: json['fantasia'] as String?,
      logoUrl: json['logo'] as String?,
      neighborhood: json['bairro'] as String?,
      distance: (json['distancia'] as num?)?.toDouble(),
      favorites: json['qtdFavoritos'] as int?,
      suites: (json['suites'] as List<dynamic>?)
          ?.map((e) => SuiteModel.fromJson(e))
          .toList(),
      reviews: json['qtdAvaliacoes'] as int?,
      rate: json['media'] as double?,
    );
  }
}
