import 'dart:convert';

import 'dados_danfe.dart';
import 'inf_supl.dart';
import 'prot_nfe.dart';

class Danfe {
  DadosDanfe? dados;
  String tipo;
  InfNFeSupl? infNFeSupl;
  ProtNFe? protNFe;
  String? qrcodePrinter;
  Danfe({
    this.dados,
    required this.tipo,
    this.infNFeSupl,
    this.protNFe,
  });

  Map<String, dynamic> toMap() {
    return {
      'dados': dados?.toMap(),
    };
  }

  factory Danfe.fromMapSat(Map<String, dynamic> map) {
    Danfe danfe = Danfe(
        dados: map['infCFe'] != null ? DadosDanfe.fromMap(map['infCFe']) : null,
        tipo: 'CFe');
    // String qrcode = (_danfe.dados?.chaveNota?.replaceAll('CFe', '') ?? '') + '|' + (_danfe.dados?.ide?.dEmi ?? '') + (_danfe.dados?.ide?.hEmi ?? '') + '|' + (_danfe.dados?.total?.valorTotal ?? '') + '|' + (_danfe.dados?.dest?.cpf ?? '') + '|' + (_danfe.dados?.ide?.assinaturaQRCODE ?? '');
    String qrcode = (danfe.dados?.ide?.assinaturaQRCODE ?? '');
    danfe.qrcodePrinter = qrcode.substring(100);
    return danfe;
  }

  factory Danfe.fromMapNFce(Map<String, dynamic> map) {
    final parseMap = map.containsKey('NFe') ? map['NFe'] : map;
    Danfe danfe = Danfe(
      dados: parseMap['infNFe'] != null
          ? DadosDanfe.fromMap(parseMap['infNFe'])
          : null,
      tipo: 'NFe',
      protNFe: map['protNFe'] != null
          ? ProtNFe.fromMap(map['protNFe'])
          : null,
      infNFeSupl: parseMap['infNFeSupl'] != null
          ? InfNFeSupl.fromMap(parseMap['infNFeSupl'])
          : null,
    );
    danfe.qrcodePrinter = danfe.infNFeSupl?.qrCode;
    return danfe;
  }

  String toJson() => json.encode(toMap());
}
