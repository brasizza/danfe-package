import 'dart:convert';

/// A classe `InfProt` representa as informações de protocolo relacionadas a uma Nota Fiscal Eletrônica (NFe).
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class InfProt {
  /// Tipo de ambiente (1 = Produção, 2 = Homologação).
  String? tpAmb;

  /// Versão do aplicativo que processou o documento.
  String? verAplic;

  /// Chave de acesso da NFe.
  String? chNFe;

  /// Data e hora do recebimento no formato UTC.
  String? dhRecbto;

  /// Número do protocolo de autorização.
  String? nProt;

  /// Valor do digest do documento.
  String? digVal;

  /// Código do status do retorno.
  String? cStat;

  /// Motivo da resposta.
  String? xMotivo;

  /// Construtor da classe `InfProt`.
  ///
  /// ### Parâmetros:
  /// - [tpAmb]: Tipo de ambiente.
  /// - [verAplic]: Versão do aplicativo.
  /// - [chNFe]: Chave de acesso da NFe.
  /// - [dhRecbto]: Data e hora do recebimento.
  /// - [nProt]: Número do protocolo.
  /// - [digVal]: Digest do documento.
  /// - [cStat]: Código do status.
  /// - [xMotivo]: Motivo do retorno.
  InfProt({
    this.tpAmb,
    this.verAplic,
    this.chNFe,
    this.dhRecbto,
    this.nProt,
    this.digVal,
    this.cStat,
    this.xMotivo,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `InfProt`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfProt infProt = InfProt(tpAmb: '1', verAplic: '1.0.0');
  /// Map<String, dynamic> mapa = infProt.toMap();
  /// print(mapa); // Saída: {tpAmb: 1, verAplic: 1.0.0}
  /// ```
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

  /// Cria uma instância de `InfProt` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `InfProt`.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfProt` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'tpAmb': '1', 'verAplic': '1.0.0'};
  /// InfProt infProt = InfProt.fromMap(mapa);
  /// print(infProt.tpAmb); // Saída: 1
  /// ```
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

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `InfProt`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfProt infProt = InfProt(tpAmb: '1', verAplic: '1.0.0');
  /// String json = infProt.toJson();
  /// print(json); // Saída: {"tpAmb":"1","verAplic":"1.0.0"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `InfProt` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfProt` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"tpAmb":"1","verAplic":"1.0.0"}';
  /// InfProt infProt = InfProt.fromJson(json);
  /// print(infProt.verAplic); // Saída: 1.0.0
  /// ```
  factory InfProt.fromJson(String source) =>
      InfProt.fromMap(json.decode(source));
}
