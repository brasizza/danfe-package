import 'dart:convert';

/// A classe `ObsFisco` representa as observações fiscais associadas a um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`).
/// - Suporte à conversão para JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class ObsFisco {
  /// Texto da observação fiscal.
  String? xTexto;

  /// Campo associado à observação fiscal.
  String? sXCampo;

  /// Construtor da classe `ObsFisco`.
  ///
  /// ### Parâmetros:
  /// - [xTexto]: Texto da observação fiscal.
  /// - [sXCampo]: Campo associado à observação fiscal.
  ObsFisco({this.xTexto, this.sXCampo});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `ObsFisco`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// ObsFisco obsFisco = ObsFisco(xTexto: 'Texto', sXCampo: 'Campo1');
  /// Map<String, dynamic> mapa = obsFisco.toMap();
  /// print(mapa); // Saída: {xTexto: Texto, sXCampo: Campo1}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'xTexto': xTexto,
      'sXCampo': sXCampo,
    };
  }

  /// Cria uma instância de `ObsFisco` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `ObsFisco`.
  ///
  /// ### Retorno:
  /// - Uma instância de `ObsFisco` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'xTexto': 'Texto', 'sXCampo': 'Campo1'};
  /// ObsFisco obsFisco = ObsFisco.fromMap(mapa);
  /// print(obsFisco.xTexto); // Saída: Texto
  /// ```
  factory ObsFisco.fromMap(Map<String, dynamic> map) {
    return ObsFisco(
      xTexto: map['xTexto'],
      sXCampo: map['sXCampo'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `ObsFisco`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// ObsFisco obsFisco = ObsFisco(xTexto: 'Texto', sXCampo: 'Campo1');
  /// String json = obsFisco.toJson();
  /// print(json); // Saída: {"xTexto":"Texto","sXCampo":"Campo1"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `ObsFisco` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `ObsFisco` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"xTexto":"Texto","sXCampo":"Campo1"}';
  /// ObsFisco obsFisco = ObsFisco.fromJson(json);
  /// print(obsFisco.sXCampo); // Saída: Campo1
  /// ```
  factory ObsFisco.fromJson(String source) =>
      ObsFisco.fromMap(json.decode(source));
}
