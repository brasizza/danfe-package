import 'dart:convert';

class InfProt {
  String? tpAmb;
  String? verAplic;
  String? chNFe;
  String? dhRecbto;
  String? nProt;
  String? digVal;
  String? cStat;
  String? xMotivo;

  InfProt(
      {this.tpAmb,
      this.verAplic,
      this.chNFe,
      this.dhRecbto,
      this.nProt,
      this.digVal,
      this.cStat,
      this.xMotivo});

  Map<String, dynamic> toMap() {
    return {
      'tpAmb': tpAmb,
      'verAplic': verAplic,
      'chNFe': chNFe,
      'dhRecbto': dhRecbto,
      'nProt': nProt,
      'digVal': digVal,
      'cStat': cStat,
      'xMotivo': xMotivo,
    };
  }

  factory InfProt.fromMap(Map<String, dynamic> map) {
    return InfProt(
      tpAmb: map['tpAmb'],
      verAplic: map['verAplic'],
      chNFe: map['chNFe'],
      dhRecbto: map['dhRecbto'],
      nProt: map['nProt'],
      digVal: map['digVal'],
      cStat: map['cStat'],
      xMotivo: map['xMotivo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfProt.fromJson(String source) =>
      InfProt.fromMap(json.decode(source));
}
