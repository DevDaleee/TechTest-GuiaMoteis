class PeriodModel {
  String? formattertime;
  String? time;
  double? priece;
  double? totalPriece;
  bool? hasCortesy;
  double? discount;

  PeriodModel({
    this.formattertime,
    this.time,
    this.priece,
    this.totalPriece,
    this.hasCortesy,
    this.discount,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      formattertime: json['tempoFormatado'] as String?,
      time: json['tempo'] as String?,
      priece: json['valor'] as double?,
      totalPriece: json['valorTotal'] as double?,
      hasCortesy: json['temCortesia'] as bool?,
      discount: (json['desconto'] != null && json['desconto'] is Map<String, dynamic>)
              ? (json['desconto']['desconto'] as num?)?.toDouble()
              : null,
    );
  }
}
