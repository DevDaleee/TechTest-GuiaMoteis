import 'package:techtest_guia_motel/models/category_item_models.dart';
import 'package:techtest_guia_motel/models/item_model.dart';
import 'package:techtest_guia_motel/models/period_model.dart';

class MotelModel {
  String? name;
  String? imageUrl;
  String? neighborhood;
  double? distancy;
  int? qFavorites;
  List<CategoryItemModels>? categoryItems;
  List<ItemModel>? items;
  List<PeriodModel>? periods;

  MotelModel({
    this.name,
    this.imageUrl,
    this.neighborhood,
    this.distancy,
    this.qFavorites,
    this.categoryItems,
    this.items,
    this.periods,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      name: json[''] as String?,
      imageUrl: json[''] as String?,
      neighborhood: json[''] as String?,
      distancy: json[''] as double?,
      qFavorites: json[''] as int?,
      categoryItems: (json['categoryItens'] as List<dynamic>?)
          ?.map((e) => CategoryItemModels.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (json['itens'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      periods: (json['periodos'] as List<dynamic>?)
          ?.map((e) => PeriodModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
