import 'package:techtest_guia_motel/models/category_item_models.dart';
import 'package:techtest_guia_motel/models/item_model.dart';
import 'package:techtest_guia_motel/models/period_model.dart';

class SuiteModel {
  String? name;
  int? quantity;
  bool? showAvailability;
  List<String>? photos;
  List<ItemModel>? items;
  List<CategoryItemModel>? categoryItems;
  List<PeriodModel>? periods;

  SuiteModel({
    this.name,
    this.quantity,
    this.showAvailability,
    this.photos,
    this.items,
    this.categoryItems,
    this.periods,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      name: json['nome'] as String?,
      quantity: json['qtd'] as int?,
      showAvailability: json['exibirQtdDisponiveis'] as bool?,
      photos:
          (json['fotos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      items: (json['itens'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e))
          .toList(),
      categoryItems: (json['categoriaItens'] as List<dynamic>?)
          ?.map((e) => CategoryItemModel.fromJson(e))
          .toList(),
      periods: (json['periodos'] as List<dynamic>?)
          ?.map((e) => PeriodModel.fromJson(e))
          .toList(),
    );
  }
}
