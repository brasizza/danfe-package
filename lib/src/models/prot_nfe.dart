import 'dart:convert';

import 'inf_prot.dart';

/// A classe `ProtNFe` representa o protocolo de uma Nota Fiscal Eletrônica (NFe).
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class ProtNFe {
  /// Versão do protocolo.
  String? sVersao;

  /// Informações do protocolo.
  InfProt? infProt;

  /// Construtor da classe `ProtNFe`.
  ///
  /// ### Parâmetros:
  /// - [sVersao]: Versão do protocolo.
  /// - [infProt]: Informações detalhadas do protocolo.
  ProtNFe({this.sVersao, this.infProt});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `ProtNFe`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// ProtNFe protNFe = ProtNFe(sVersao: '4.0', infProt: InfProt(tpAmb: '1'));
  /// Map<String, dynamic> mapa = protNFe.toMap();
  /// print(mapa); // Saída: {sVersao: 4.0, infProt: {tpAmb: 1}}
  /// ```
  Map<String, dynamic> toMap() {
    return {'sVersao': sVersao, 'infProt': infProt?.toMap()};
  }

  /// Cria uma instância de `ProtNFe` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `ProtNFe`.
  ///
  /// ### Retorno:
  /// - Uma instância de `ProtNFe` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {
  ///   '_versao': '4.0',
  ///   'infProt': {'tpAmb': '1'}
  /// };
  /// ProtNFe protNFe = ProtNFe.fromMap(mapa);
  /// print(protNFe.sVersao); // Saída: 4.0
  /// ```
  factory ProtNFe.fromMap(Map<String, dynamic> map) {
    return ProtNFe(
      sVersao: map['_versao'],
      infProt: map['infProt'] != null ? InfProt.fromMap(map['infProt']) : null,
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `ProtNFe`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// ProtNFe protNFe = ProtNFe(sVersao: '4.0', infProt: InfProt(tpAmb: '1'));
  /// String json = protNFe.toJson();
  /// print(json); // Saída: {"sVersao":"4.0","infProt":{"tpAmb":"1"}}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `ProtNFe` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `ProtNFe` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"sVersao":"4.0","infProt":{"tpAmb":"1"}}';
  /// ProtNFe protNFe = ProtNFe.fromJson(json);
  /// print(protNFe.infProt?.tpAmb); // Saída: 1
  /// ```
  factory ProtNFe.fromJson(String source) =>
      ProtNFe.fromMap(json.decode(source));
}
