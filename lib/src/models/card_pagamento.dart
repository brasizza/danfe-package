import 'dart:convert';

class CardPagamento {
  String? tpIntegra;
  String? cNPJ;
  String? tBand;

  CardPagamento({this.tpIntegra, this.cNPJ, this.tBand});

  Map<String, dynamic> toMap() {
    return {
      'tpIntegra': tpIntegra,
      'cNPJ': cNPJ,
      'tBand': tBand,
    };
  }

  factory CardPagamento.fromMap(Map<String, dynamic> map) {
    return CardPagamento(
      tpIntegra: map['tpIntegra'],
      cNPJ: map['cNPJ'],
      tBand: map['tBand'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardPagamento.fromJson(String source) =>
      CardPagamento.fromMap(json.decode(source));
}
