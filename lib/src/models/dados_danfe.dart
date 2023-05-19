import 'dart:convert';

import 'dest.dart';
import 'det.dart';
import 'emit.dart';
import 'ide.dart';
import 'inf_adic.dart';
import 'pgto.dart';
import 'total.dart';

class DadosDanfe {
  Ide? ide;
  Emit? emit;
  Dest? dest;
  List<Det>? det;
  Total? total;
  Pgto? pgto;
  InfAdic? infAdic;
  String? chaveNota;
  String? sVersao;
  String? sVersaoDadosEnt;
  String? sVersaoSB;

  DadosDanfe(
      {this.ide,
      this.emit,
      this.dest,
      this.det,
      this.total,
      this.pgto,
      this.infAdic,
      this.chaveNota,
      this.sVersao,
      this.sVersaoDadosEnt,
      this.sVersaoSB});

  Map<String, dynamic> toMap() {
    return {
      'ide': ide?.toMap(),
      'emit': emit?.toMap(),
      'dest': dest?.toMap(),
      'det': det?.map((x) => x.toMap()).toList(),
      'total': total?.toMap(),
      'pgto': pgto?.toMap(),
      'infAdic': infAdic?.toMap(),
      'chaveNota': chaveNota,
      'sVersao': sVersao,
      'sVersaoDadosEnt': sVersaoDadosEnt,
      'sVersaoSB': sVersaoSB,
    };
  }

  factory DadosDanfe.fromMap(Map<String, dynamic> map) {
    List<Det> det = [];
    if (map['det'].runtimeType.toString() != 'List<dynamic>') {
      det.add(Det.fromMap(map['det']));
    } else {
      det.addAll(List<Det>.from(map['det']?.map((x) => Det.fromMap(x))));
    }
    return DadosDanfe(
      ide: map['ide'] != null ? Ide.fromMap(map['ide']) : null,
      emit: map['emit'] != null ? Emit.fromMap(map['emit']) : null,
      dest: (map['dest'] != null && map['dest'] != '')
          ? Dest.fromMap(map['dest'])
          : null,
      det: map['det'] != null ? det : null,
      total: map['total'] != null ? Total.fromMap(map['total']) : null,
      pgto: (map['pgto'] != null || map['pag'] != null)
          ? Pgto.fromMap(map.containsKey('pgto') ? map['pgto'] : map['pag'])
          : null,
      infAdic: map['infAdic'] != null ? InfAdic.fromMap(map['infAdic']) : null,
      chaveNota:
          (map['_Id'] as String).replaceAll('CFe', '').replaceAll('NFe', ''),
      sVersao: map['_versao'],
      sVersaoDadosEnt: map['_versaoDadosEnt'],
      sVersaoSB: map['_versaoSB'],
    );
  }
  String toJson() => json.encode(toMap());
  factory DadosDanfe.fromJson(String source) =>
      DadosDanfe.fromMap(json.decode(source));
}
