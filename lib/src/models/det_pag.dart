import 'dart:convert';

import 'card_pagamento.dart';

/// A classe `DetPag` representa os detalhes de um pagamento em um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class DetPag {
  /// Tipo de pagamento (ex.: dinheiro, cartão de crédito).
  String? tPag;

  /// Valor pago no respectivo tipo de pagamento.
  String? vPag;

  /// Informações do cartão, se o pagamento foi realizado com cartão.
  CardPagamento? card;

  /// Construtor da classe `DetPag`.
  ///
  /// ### Parâmetros:
  /// - [tPag]: Tipo de pagamento.
  /// - [vPag]: Valor pago.
  /// - [card]: Informações do cartão de pagamento (opcional).
  DetPag({this.tPag, this.vPag, this.card});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `DetPag`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// DetPag detPag = DetPag(tPag: '01', vPag: '100.00');
  /// Map<String, dynamic> mapa = detPag.toMap();
  /// print(mapa); // Saída: {tPag: 01, vPag: 100.00}
  /// ```
  Map<String, dynamic> toMap() {
    return {'tPag': tPag, 'vPag': vPag, 'card': card?.toMap()};
  }

  /// Cria uma instância de `DetPag` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `DetPag`.
  ///
  /// ### Retorno:
  /// - Uma instância de `DetPag` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'tPag': '01', 'vPag': '100.00'};
  /// DetPag detPag = DetPag.fromMap(mapa);
  /// print(detPag.tPag); // Saída: 01
  /// ```
  factory DetPag.fromMap(Map<String, dynamic> map) {
    return DetPag(
      tPag: map['tPag'],
      vPag: map['vPag'],
      card: map['card'] != null ? CardPagamento.fromMap(map['card']) : null,
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `DetPag`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// DetPag detPag = DetPag(tPag: '01', vPag: '100.00');
  /// String json = detPag.toJson();
  /// print(json); // Saída: {"tPag":"01","vPag":"100.00"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `DetPag` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `DetPag` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"tPag":"01","vPag":"100.00"}';
  /// DetPag detPag = DetPag.fromJson(json);
  /// print(detPag.vPag); // Saída: 100.00
  /// ```
  factory DetPag.fromJson(String source) => DetPag.fromMap(json.decode(source));
}
