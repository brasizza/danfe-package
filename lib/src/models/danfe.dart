import 'dart:convert';

import 'dados_danfe.dart';
import 'inf_supl.dart';
import 'prot_nfe.dart';

/// Enum que representa os tipos de documentos fiscais.
// ignore: constant_identifier_names
enum TipoDocumento { CFe, NFe, NFCe }

/// Extensão para facilitar a conversão entre `TipoDocumento` e `String`.
extension TipoDocumentoExtension on TipoDocumento {
  /// Obtém o valor em string correspondente ao tipo de documento.
  String get value {
    switch (this) {
      case TipoDocumento.CFe:
        return 'CFe';
      case TipoDocumento.NFe:
        return 'NFe';
      case TipoDocumento.NFCe:
        return 'NFCe';
    }
  }

  /// Converte uma string em uma enumeração `TipoDocumento`.
  static TipoDocumento fromString(String value) {
    switch (value) {
      case 'CFe':
        return TipoDocumento.CFe;
      case 'NFe':
        return TipoDocumento.NFe;
      case 'NFCe':
        return TipoDocumento.NFCe;
      default:
        throw ArgumentError('Tipo de documento desconhecido: $value');
    }
  }
}

/// A classe `Danfe` representa os dados estruturados de um DANFE (Documento Auxiliar da Nota Fiscal Eletrônica).
///
/// ### Responsabilidades:
/// - Centralizar informações do DANFE, incluindo dados principais, tipo, informações suplementares,
///   protocolo de autorização e QR Code.
/// - Fornecer métodos de conversão entre mapas (`Map<String, dynamic>`) e JSON.
///
/// Essa classe suporta dois tipos principais de documentos fiscais:
/// - `CFe`: Cupom Fiscal Eletrônico.
/// - `NFe`: Nota Fiscal Eletrônica.
class Danfe {
  /// Dados principais do DANFE.
  /// Instância da classe [DadosDanfe], que centraliza as informações do documento fiscal.
  DadosDanfe? dados;

  /// Tipo do documento fiscal (ex.: `CFe` ou `NFe`).
  TipoDocumento tipo;

  /// Informações suplementares da Nota Fiscal.
  /// Instância da classe [InfNFeSupl], contendo informações adicionais, como QR Code e URL de consulta.
  InfNFeSupl? infNFeSupl;

  /// Protocolo de autorização da Nota Fiscal.
  /// Representado por uma instância da classe [ProtNFe], que inclui detalhes como número do protocolo e data de recebimento.
  ProtNFe? protNFe;

  /// QR Code preparado para impressão.
  /// Representa o código de barras bidimensional gerado para a nota fiscal.
  String? qrcodePrinter;

  /// Construtor da classe `Danfe`.
  ///
  /// ### Parâmetros:
  /// - [dados]: Dados principais do DANFE.
  /// - [tipo]: Tipo do documento fiscal (obrigatório).
  /// - [infNFeSupl]: Informações suplementares da Nota Fiscal.
  /// - [protNFe]: Protocolo de autorização da Nota Fiscal.
  Danfe({this.dados, required this.tipo, this.infNFeSupl, this.protNFe});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os dados principais do DANFE.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Danfe danfe = Danfe(tipo: TipoDocumento.NFe, dados: DadosDanfe(...));
  /// Map<String, dynamic> mapa = danfe.toMap();
  /// print(mapa); // Saída: {dados: {...}}
  /// ```
  Map<String, dynamic> toMap() {
    return {'dados': dados?.toMap(), 'tipo': tipo.value, 'infNFeSupl': infNFeSupl?.toMap(), 'protNFe': protNFe?.toMap(), 'qrcodePrinter': qrcodePrinter};
  }

  /// Método utilitário para obter um valor de forma segura de um mapa.
  static T? safeGet<T>(Map<String, dynamic> map, String key) {
    return map.containsKey(key) && map[key] != null ? map[key] as T : null;
  }

  static String? extractQrCode(String? qrCode) {
    if (qrCode == null || qrCode.length < 100) {
      return null;
    }
    return qrCode.substring(100);
  }

  /// Cria uma instância de `Danfe` a partir de um mapa no formato SAT.
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo os dados no formato SAT (Cupom Fiscal Eletrônico).
  ///
  /// ### Retorno:
  /// - Uma instância de `Danfe` com os valores mapeados.
  ///
  /// ### Detalhes:
  /// - O QR Code é extraído do campo `assinaturaQRCODE` do campo `ide` e ajustado para impressão.
  factory Danfe.fromMapSat(Map<String, dynamic> map) {
    final dados = safeGet<Map<String, dynamic>>(map, 'infCFe');
    return Danfe(dados: dados != null ? DadosDanfe.fromMap(dados) : null, tipo: TipoDocumento.CFe)..qrcodePrinter = extractQrCode(dados?['ide']?['assinaturaQRCODE']);
  }

  /// Cria uma instância de `Danfe` a partir de um mapa no formato NFC-e.
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo os dados no formato NFC-e (Nota Fiscal Eletrônica do Consumidor).
  ///
  /// ### Retorno:
  /// - Uma instância de `Danfe` com os valores mapeados.
  ///
  /// ### Detalhes:
  /// - O QR Code é extraído do campo `infNFeSupl` e ajustado para impressão.
  /// - Inclui informações suplementares (`infNFeSupl`) e protocolo de autorização (`protNFe`).
  factory Danfe.fromMapNFce(Map<String, dynamic> map) {
    final parseMap = safeGet<Map<String, dynamic>>(map, 'NFe') ?? map;
    return Danfe(
      dados: safeGet<Map<String, dynamic>>(parseMap, 'infNFe') != null ? DadosDanfe.fromMap(parseMap['infNFe']) : null,
      tipo: findTypeByMap(parseMap) ?? TipoDocumento.NFCe,
      protNFe: safeGet<Map<String, dynamic>>(map, 'protNFe') != null ? ProtNFe.fromMap(map['protNFe']) : null,
      infNFeSupl: safeGet<Map<String, dynamic>>(parseMap, 'infNFeSupl') != null ? InfNFeSupl.fromMap(parseMap['infNFeSupl']) : null,
    )..qrcodePrinter = safeGet<Map<String, dynamic>>(parseMap, 'infNFeSupl')?['qrCode'];
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON representando os dados principais do DANFE.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Danfe danfe = Danfe(tipo: TipoDocumento.CFe, dados: DadosDanfe(...));
  /// String json = danfe.toJson();
  /// print(json); // Saída: {"dados":{...}}
  /// ```
  String toJson() => json.encode(toMap());

  static TipoDocumento? findTypeByMap(Map<String, dynamic> map) {
    if (map.containsKey('CFe')) {
      return TipoDocumento.CFe;
    } else if (map.containsKey('infNFe')) {
      if (map['infNFe']?['ide']?['mod'] == '55') {
        return TipoDocumento.NFe;
      }
      return TipoDocumento.NFCe;
    }
    return TipoDocumento.NFe;
  }
}
