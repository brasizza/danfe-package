import 'dart:convert';

import 'obs_fisco.dart';

/// A classe `InfAdic` representa as informações adicionais de um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class InfAdic {
  /// Informações complementares do documento fiscal.
  String? infCpl;

  /// Observações fiscais associadas ao documento.
  ObsFisco? obsFisco;

  /// Construtor da classe `InfAdic`.
  ///
  /// ### Parâmetros:
  /// - [infCpl]: Informações complementares.
  /// - [obsFisco]: Observações fiscais associadas.
  InfAdic({this.infCpl, this.obsFisco});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `InfAdic`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfAdic infAdic = InfAdic(infCpl: 'Informações adicionais aqui');
  /// Map<String, dynamic> mapa = infAdic.toMap();
  /// print(mapa); // Saída: {infCpl: Informações adicionais aqui, obsFisco: null}
  /// ```
  Map<String, dynamic> toMap() {
    return {'infCpl': infCpl, 'obsFisco': obsFisco?.toMap()};
  }

  /// Cria uma instância de `InfAdic` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `InfAdic`.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfAdic` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'infCpl': 'Informações adicionais aqui'};
  /// InfAdic infAdic = InfAdic.fromMap(mapa);
  /// print(infAdic.infCpl); // Saída: Informações adicionais aqui
  /// ```
  factory InfAdic.fromMap(Map<String, dynamic> map) {
    return InfAdic(
      infCpl: map['infCpl'],
      obsFisco: map['obsFisco'] != null
          ? ObsFisco.fromMap(map['obsFisco'])
          : null,
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `InfAdic`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfAdic infAdic = InfAdic(infCpl: 'Informações adicionais aqui');
  /// String json = infAdic.toJson();
  /// print(json); // Saída: {"infCpl":"Informações adicionais aqui","obsFisco":null}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `InfAdic` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfAdic` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"infCpl":"Informações adicionais aqui"}';
  /// InfAdic infAdic = InfAdic.fromJson(json);
  /// print(infAdic.infCpl); // Saída: Informações adicionais aqui
  /// ```
  factory InfAdic.fromJson(String source) =>
      InfAdic.fromMap(json.decode(source));
}
