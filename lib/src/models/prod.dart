import 'dart:convert';

class Prod {
  String? cProd;
  String? xProd;
  String? nCM;
  String? cFOP;
  String? uCom;
  String? qCom;
  String? vUnCom;
  String? vProd;
  String? indRegra;
  String? vItem;
  String? vDesc;
  Prod(
      {this.cProd,
      this.xProd,
      this.nCM,
      this.cFOP,
      this.uCom,
      this.qCom,
      this.vUnCom,
      this.vProd,
      this.indRegra,
      this.vItem,
      this.vDesc});

  Map<String, dynamic> toMap() {
    return {
      'cProd': cProd,
      'xProd': xProd,
      'nCM': nCM,
      'cFOP': cFOP,
      'uCom': uCom,
      'qCom': qCom,
      'vUnCom': vUnCom,
      'vProd': vProd,
      'indRegra': indRegra,
      'vItem': vItem,
      'vDesc': vDesc,
    };
  }

  factory Prod.fromMap(Map<String, dynamic> map) {
    return Prod(
      cProd: map['cProd'],
      xProd: map['xProd'],
      nCM: map['NCM'],
      cFOP: map['CFOP'],
      uCom: map['uCom'],
      qCom: map['qCom'],
      vUnCom: map['vUnCom'],
      vProd: map['vProd'],
      indRegra: map['indRegra'],
      vItem: (map.containsKey('vItem') ? (map['vItem']) : map['vUnCom']) ?? '',
      vDesc:
          (map.containsKey('vRatDesc') ? (map['vRatDesc']) : map['vRatDesc']) ??
              '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Prod.fromJson(String source) => Prod.fromMap(json.decode(source));
}
