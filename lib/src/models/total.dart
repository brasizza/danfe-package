// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Total {
  String? valorTotal;
  String? valorTotalIcms;
  String? valorLei12741;
  String? desconto;
  String? acrescimo;
  String? valorPago;
  Total({
    this.valorTotal,
    this.valorTotalIcms,
    this.valorLei12741,
    this.desconto,
    this.acrescimo,
    this.valorPago,
  });

  Map<String, dynamic> toMap() {
    return {
      'valorTotal': valorTotal,
      'valorPago': valorPago,
      'desconto': desconto,
      'acrescimo': acrescimo,
    };
  }

  factory Total.fromMap(Map<String, dynamic> map) {
    return Total(
      valorTotalIcms: (map['ICMSTot']['vProd']),
      valorTotal: (map.containsKey('vCFe') ? (map['vCFe']) : (map['ICMSTot']['vProd'])) ?? '0.00',
      valorLei12741: map.containsKey('vCFeLei12741') ? map['vCFeLei12741'] : '0.00',
      desconto: (map.containsKey('vCFe') ? (map['DescAcrEntr']?['vDescSubtot']) : map['ICMSTot']['vDesc']) ?? '0.00',
      acrescimo: (map.containsKey('vCFe') ? '0.00' : map['ICMSTot']['vOutro']),
      valorPago: ((map.containsKey('vCFe') ? map['vCFe'] : map['ICMSTot']['vNF'])) ?? '0.00',
    );
  }

  String toJson() => json.encode(toMap());

  factory Total.fromJson(String source) => Total.fromMap(json.decode(source));
}
