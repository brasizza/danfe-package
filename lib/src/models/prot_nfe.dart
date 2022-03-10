import 'dart:convert';

import 'inf_prot.dart';

class ProtNFe {
  String? sVersao;
  InfProt? infProt;

  ProtNFe({this.sVersao, this.infProt});

  Map<String, dynamic> toMap() {
    return {
      'sVersao': sVersao,
      'infProt': infProt?.toMap(),
    };
  }

  factory ProtNFe.fromMap(Map<String, dynamic> map) {
    return ProtNFe(
      sVersao: map['_versao'],
      infProt: map['infProt'] != null ? InfProt.fromMap(map['infProt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProtNFe.fromJson(String source) =>
      ProtNFe.fromMap(json.decode(source));
}
