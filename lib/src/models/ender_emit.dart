import 'dart:convert';

class EnderEmit {
  String? xLgr;
  String? nro;
  String? xCpl;
  String? xBairro;
  String? cMun;
  String? xMun;
  String? uF;
  String? cEP;
  String? cPais;
  String? xPais;
  String? fone;

  EnderEmit(
      {this.xLgr,
      this.nro,
      this.xCpl,
      this.xBairro,
      this.cMun,
      this.xMun,
      this.uF,
      this.cEP,
      this.cPais,
      this.xPais,
      this.fone});

  Map<String, dynamic> toMap() {
    return {
      'xLgr': xLgr,
      'nro': nro,
      'xCpl': xCpl,
      'xBairro': xBairro,
      'cMun': cMun,
      'xMun': xMun,
      'uF': uF,
      'cEP': cEP,
      'cPais': cPais,
      'xPais': xPais,
      'fone': fone,
    };
  }

  factory EnderEmit.fromMap(Map<String, dynamic> map) {
    return EnderEmit(
      xLgr: map['xLgr'],
      nro: map['nro'],
      xCpl: map['xCpl'],
      xBairro: map['xBairro'],
      cMun: map['cMun'],
      xMun: map['xMun'],
      uF: map['UF'],
      cEP: map['CEP'],
      cPais: map['cPais'],
      xPais: map['xPais'],
      fone: map['fone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderEmit.fromJson(String source) =>
      EnderEmit.fromMap(json.decode(source));
}
