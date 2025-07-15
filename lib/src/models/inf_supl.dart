import 'dart:convert';

/// A classe `InfNFeSupl` representa as informações suplementares de uma Nota Fiscal Eletrônica (NFe).
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class InfNFeSupl {
  /// QR Code associado à Nota Fiscal Eletrônica.
  String? qrCode;

  /// URL para consulta da chave de acesso da NFe.
  String? urlChave;

  /// Construtor da classe `InfNFeSupl`.
  ///
  /// ### Parâmetros:
  /// - [qrCode]: QR Code da NFe.
  /// - [urlChave]: URL para consulta da chave de acesso.
  InfNFeSupl({this.qrCode, this.urlChave});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `InfNFeSupl`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfNFeSupl infNFeSupl = InfNFeSupl(qrCode: '12345', urlChave: 'https://url.com');
  /// Map<String, dynamic> mapa = infNFeSupl.toMap();
  /// print(mapa); // Saída: {qrCode: 12345, urlChave: https://url.com}
  /// ```
  Map<String, dynamic> toMap() {
    return {'qrCode': qrCode, 'urlChave': urlChave};
  }

  /// Cria uma instância de `InfNFeSupl` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `InfNFeSupl`.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfNFeSupl` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'qrCode': '12345', 'urlChave': 'https://url.com'};
  /// InfNFeSupl infNFeSupl = InfNFeSupl.fromMap(mapa);
  /// print(infNFeSupl.qrCode); // Saída: 12345
  /// ```
  factory InfNFeSupl.fromMap(Map<String, dynamic> map) {
    return InfNFeSupl(qrCode: map['qrCode'], urlChave: map['urlChave']);
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `InfNFeSupl`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// InfNFeSupl infNFeSupl = InfNFeSupl(qrCode: '12345', urlChave: 'https://url.com');
  /// String json = infNFeSupl.toJson();
  /// print(json); // Saída: {"qrCode":"12345","urlChave":"https://url.com"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `InfNFeSupl` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `InfNFeSupl` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"qrCode":"12345","urlChave":"https://url.com"}';
  /// InfNFeSupl infNFeSupl = InfNFeSupl.fromJson(json);
  /// print(infNFeSupl.urlChave); // Saída: https://url.com
  /// ```
  factory InfNFeSupl.fromJson(String source) =>
      InfNFeSupl.fromMap(json.decode(source));
}
