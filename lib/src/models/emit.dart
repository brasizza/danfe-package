import 'dart:convert';

import 'ender_emit.dart';

class Emit {
  String? cnpj;
  String? xNome;
  String? xFant;
  String? iE;
  String? iM;
  String? cRegTrib;
  String? indRatISSQN;
  EnderEmit? enderEmit;
  Emit(
      {this.cnpj,
      this.xNome,
      this.xFant,
      this.iE,
      this.iM,
      this.cRegTrib,
      this.indRatISSQN,
      this.enderEmit});

  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
      'xNome': xNome,
      'xFant': xFant,
      'iE': iE,
      'iM': iM,
      'cRegTrib': cRegTrib,
      'indRatISSQN': indRatISSQN,
      'enderEmit': enderEmit?.toMap(),
    };
  }

  factory Emit.fromMap(Map<String, dynamic> map) {
    return Emit(
      cnpj: map['CNPJ'],
      xNome: map['xNome'],
      xFant: map['xFant'],
      iE: map['IE'],
      iM: map['IM'],
      cRegTrib: map['cRegTrib'],
      indRatISSQN: map['indRatISSQN'],
      enderEmit:
          map['enderEmit'] != null ? EnderEmit.fromMap(map['enderEmit']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Emit.fromJson(String source) => Emit.fromMap(json.decode(source));
}
