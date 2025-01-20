import 'dart:convert';

import 'mp.dart';

/// A classe `Pgto` representa as informações de pagamento em um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Suporte a múltiplas formas de pagamento (cartão, dinheiro, etc.).
/// - Permite inicialização a partir de diferentes estruturas de mapas.
class Pgto {
  /// Lista de formas de pagamento utilizadas.
  List<MP>? formas;

  /// Valor do troco.
  String? vTroco;

  /// Construtor da classe `Pgto`.
  ///
  /// ### Parâmetros:
  /// - [formas]: Lista de formas de pagamento.
  /// - [vTroco]: Valor do troco (se aplicável).
  Pgto({this.formas, this.vTroco});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `Pgto`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Pgto pgto = Pgto(formas: [MP(cMP: '01', vMP: '100.00')], vTroco: '0.00');
  /// Map<String, dynamic> mapa = pgto.toMap();
  /// print(mapa); // Saída: {MP: [{cMP: 01, vMP: 100.00}], vTroco: 0.00}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'MP': formas?.map((x) => x.toMap()).toList(),
      'vTroco': vTroco,
    };
  }

  /// Cria uma instância de `Pgto` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `Pgto`.
  ///
  /// ### Retorno:
  /// - Uma instância de `Pgto` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {
  ///   'MP': [{'cMP': '01', 'vMP': '100.00'}],
  ///   'vTroco': '0.00'
  /// };
  /// Pgto pgto = Pgto.fromMap(mapa);
  /// print(pgto.formas?.first.cMP); // Saída: 01
  /// ```
  factory Pgto.fromMap(Map<String, dynamic> map) {
    final List<MP>? formasPagamento = (map['MP'] ?? map['detPag']) is List
        ? List<MP>.from((map['MP'] ?? map['detPag']).map((x) => MP.fromMap(x)))
        : map['MP'] != null || map['detPag'] != null
            ? [MP.fromMap(map['MP'] ?? map['detPag'])]
            : null;

    return Pgto(
      formas: formasPagamento,
      vTroco: map['vTroco'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `Pgto`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Pgto pgto = Pgto(formas: [MP(cMP: '01', vMP: '100.00')], vTroco: '0.00');
  /// String json = pgto.toJson();
  /// print(json); // Saída: {"MP":[{"cMP":"01","vMP":"100.00"}],"vTroco":"0.00"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Pgto` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Pgto` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"MP":[{"cMP":"01","vMP":"100.00"}],"vTroco":"0.00"}';
  /// Pgto pgto = Pgto.fromJson(json);
  /// print(pgto.vTroco); // Saída: 0.00
  /// ```
  factory Pgto.fromJson(String source) => Pgto.fromMap(json.decode(source));
}
