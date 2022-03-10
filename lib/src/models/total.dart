import 'dart:convert';

class Total {
  String? valorTotal;
  String? desconto;
  String? acrescimo;
  Total({this.valorTotal, this.desconto, this.acrescimo});

  Map<String, dynamic> toMap() {
    return {
      'valorTotal': valorTotal,
      'desconto': desconto,
      'acrescimo': acrescimo,
    };
  }

  factory Total.fromMap(Map<String, dynamic> map) {
    return Total(
      valorTotal:
          (map.containsKey('vCFe') ? map['vCFe'] : map['ICMSTot']['vNF']),
      desconto: (map.containsKey('vCFe')
          ? (map['DescAcrEntr']?['vDescSubtot'])
          : map['ICMSTot']['vDesc']),
      acrescimo: (map.containsKey('vCFe') ? null : map['ICMSTot']['vOutro']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Total.fromJson(String source) => Total.fromMap(json.decode(source));
}
