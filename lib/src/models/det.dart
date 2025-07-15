import 'dart:convert';

import 'prod.dart';

/// A classe `Det` representa os detalhes de um item em um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class Det {
  /// Informações do produto associado ao item.
  Prod? prod;

  /// Número sequencial do item no documento fiscal.
  String? sNItem;

  /// Construtor da classe `Det`.
  ///
  /// ### Parâmetros:
  /// - [prod]: Informações do produto.
  /// - [sNItem]: Número sequencial do item.
  Det({this.prod, this.sNItem});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `Det`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Det det = Det(prod: Prod(nome: 'Produto A'), sNItem: '001');
  /// Map<String, dynamic> mapa = det.toMap();
  /// print(mapa); // Saída: {prod: {...}, sNItem: 001}
  /// ```
  Map<String, dynamic> toMap() {
    return {'prod': prod?.toMap(), 'sNItem': sNItem};
  }

  /// Cria uma instância de `Det` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `Det`.
  ///
  /// ### Retorno:
  /// - Uma instância de `Det` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'prod': {...}, '_nItem': '001'};
  /// Det det = Det.fromMap(mapa);
  /// print(det.sNItem); // Saída: 001
  /// ```
  factory Det.fromMap(Map<String, dynamic> map) {
    return Det(
      prod: map['prod'] != null ? Prod.fromMap(map['prod']) : null,
      sNItem: map['_nItem'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `Det`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Det det = Det(prod: Prod(nome: 'Produto A'), sNItem: '001');
  /// String json = det.toJson();
  /// print(json); // Saída: {"prod":{...},"sNItem":"001"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Det` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Det` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"prod":{...},"_nItem":"001"}';
  /// Det det = Det.fromJson(json);
  /// print(det.sNItem); // Saída: 001
  /// ```
  factory Det.fromJson(String source) => Det.fromMap(json.decode(source));
}
