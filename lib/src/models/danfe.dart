import 'dart:convert';
import 'dados_danfe.dart';
import 'ender_emit.dart';
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
    Danfe _danfe = Danfe(
        dados: map['infCFe'] != null ? DadosDanfe.fromMap(map['infCFe']) : null,
        tipo: 'CFe');
    // String qrcode = (_danfe.dados?.chaveNota?.replaceAll('CFe', '') ?? '') + '|' + (_danfe.dados?.ide?.dEmi ?? '') + (_danfe.dados?.ide?.hEmi ?? '') + '|' + (_danfe.dados?.total?.valorTotal ?? '') + '|' + (_danfe.dados?.dest?.cpf ?? '') + '|' + (_danfe.dados?.ide?.assinaturaQRCODE ?? '');
    String qrcode = (_danfe.dados?.ide?.assinaturaQRCODE ?? '');
    _danfe.qrcodePrinter = qrcode.substring(100);
    return _danfe;
  }

  factory Danfe.fromMapNFce(Map<String, dynamic> map) {
    Danfe _danfe = Danfe(
      dados: map['NFe']['infNFe'] != null
          ? DadosDanfe.fromMap(map['NFe']['infNFe'])
          : null,
      tipo: 'NFe',
      protNFe: map['protNFe'] != null ? ProtNFe.fromMap(map['protNFe']) : null,
      infNFeSupl: map['NFe']['infNFeSupl'] != null
          ? InfNFeSupl.fromMap(map['NFe']['infNFeSupl'])
          : null,
    );
    _danfe.qrcodePrinter = _danfe.infNFeSupl?.qrCode;
    return _danfe;
  }

  String toJson() => json.encode(toMap());
}
