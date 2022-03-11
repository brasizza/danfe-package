import 'dart:convert';

class Total {
  String? valorTotal;
  String? desconto;
  String? acrescimo;
  String? valorPago;
  Total({this.valorTotal, this.desconto, this.acrescimo, this.valorPago});

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
      valorTotal: (map['ICMSTot']['vProd']),
      desconto: (map.containsKey('vCFe')
              ? (map['DescAcrEntr']?['vDescSubtot'])
              : map['ICMSTot']['vDesc']) ??
          '0.00',
      acrescimo: (map.containsKey('vCFe') ? '0.00' : map['ICMSTot']['vOutro']),
      valorPago: (map['vCFe']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Total.fromJson(String source) => Total.fromMap(json.decode(source));
}
