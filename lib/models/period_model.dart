class PeriodModel {
  String? formattedTime;
  String? time;
  double? price;
  double? totalPrice;
  bool? hasCourtesy;
  double? discount;

  PeriodModel({
    this.formattedTime,
    this.time,
    this.price,
    this.totalPrice,
    this.hasCourtesy,
    this.discount,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      formattedTime: json['tempoFormatado'] as String?,
      time: json['tempo'] as String?,
      price: (json['valor'] as num?)?.toDouble(),
      totalPrice: (json['valorTotal'] as num?)?.toDouble(),
      hasCourtesy: json['temCortesia'] as bool?,
      discount:
          (json['desconto'] != null && json['desconto'] is Map<String, dynamic>)
              ? (json['desconto']['desconto'] as num?)?.toDouble()
              : null,
    );
  }
}
