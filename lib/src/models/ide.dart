import 'dart:convert';

class Ide {
  String? cUF;
  String? cNF;
  String? mod;
  String? nserieSAT;
  String? dEmi;
  String? hEmi;
  String? cDV;
  String? tpAmb;
  String? cNPJ;
  String? signAC;
  String? assinaturaQRCODE;
  String? numeroCaixa;
  String? nNF;
  String? dhEmi;

  Ide(
      {this.cUF,
      this.cNF,
      this.mod,
      this.nserieSAT,
      this.dEmi,
      this.hEmi,
      this.cDV,
      this.tpAmb,
      this.cNPJ,
      this.signAC,
      this.assinaturaQRCODE,
      this.numeroCaixa,
      this.nNF,
      this.dhEmi});

  Map<String, dynamic> toMap() {
    return {
      'cUF': cUF,
      'cNF': cNF,
      'mod': mod,
      'nserieSAT': nserieSAT,
      'dEmi': dEmi,
      'hEmi': hEmi,
      'cDV': cDV,
      'nNF': nNF,
      'dhEmi': dhEmi,
      'tpAmb': tpAmb,
      'cNPJ': cNPJ,
      'signAC': signAC,
      'assinaturaQRCODE': assinaturaQRCODE,
      'numeroCaixa': numeroCaixa,
    };
  }

  factory Ide.fromMap(Map<String, dynamic> map) {
    return Ide(
      cUF: map['cUF'],
      cNF: map['cNF'],
      mod: map['mod'],
      nserieSAT: map['nserieSAT'],
      dEmi: map['dEmi'],
      hEmi: map['hEmi'],
      cDV: map['cDV'],
      tpAmb: map['tpAmb'],
      cNPJ: map['CNPJ'],
      signAC: map['signAC'],
      assinaturaQRCODE: map['assinaturaQRCODE'],
      numeroCaixa: map['numeroCaixa'],
      nNF: map.containsKey('nCFe') ? map['nCFe'] : map['nNF'],
      dhEmi: map['dhEmi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ide.fromJson(String source) => Ide.fromMap(json.decode(source));
}
