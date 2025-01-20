import 'dart:convert';

/// A classe `CardPagamento` representa os dados de um cartão de pagamento, com campos
/// que incluem informações como tipo de integração, CNPJ e bandeira do cartão.
///
/// ### Funcionalidades:
/// - Conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Criação de instâncias a partir de mapas e JSON.
///
/// Essa classe é útil para manipular informações de pagamento em sistemas que lidam com dados estruturados.
class CardPagamento {
  /// Tipo de integração do cartão de pagamento.
  ///
  /// Este campo pode conter valores que indicam como o pagamento foi processado,
  /// como integração direta ou intermediada.
  String? tpIntegra;

  /// CNPJ da empresa responsável pelo cartão ou pela integração.
  ///
  /// Este campo pode ser usado para identificar a instituição ou provedor
  /// envolvido no processamento do pagamento.
  String? cNPJ;

  /// Bandeira do cartão (ex.: Visa, MasterCard).
  ///
  /// Este campo armazena a informação sobre a bandeira do cartão utilizada no pagamento.
  String? tBand;

  /// Construtor da classe `CardPagamento`.
  ///
  /// ### Parâmetros:
  /// - [tpIntegra]: Tipo de integração do pagamento.
  /// - [cNPJ]: CNPJ relacionado ao pagamento.
  /// - [tBand]: Bandeira do cartão.
  CardPagamento({this.tpIntegra, this.cNPJ, this.tBand});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores dos campos `tpIntegra`, `cNPJ` e `tBand`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// CardPagamento card = CardPagamento(tpIntegra: '2', cNPJ: '12345678000123', tBand: 'Visa');
  /// Map<String, dynamic> mapa = card.toMap();
  /// print(mapa); // Saída: {tpIntegra: 2, cNPJ: 12345678000123, tBand: Visa}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'tpIntegra': tpIntegra,
      'cNPJ': cNPJ,
      'tBand': tBand,
    };
  }

  /// Cria uma instância de `CardPagamento` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes aos campos da classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `CardPagamento` com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'tpIntegra': '2', 'cNPJ': '12345678000123', 'tBand': 'Visa'};
  /// CardPagamento card = CardPagamento.fromMap(mapa);
  /// print(card.tpIntegra); // Saída: 2
  /// ```
  factory CardPagamento.fromMap(Map<String, dynamic> map) {
    return CardPagamento(
      tpIntegra: map['tpIntegra'],
      cNPJ: map['cNPJ'],
      tBand: map['tBand'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string contendo os dados da classe no formato JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// CardPagamento card = CardPagamento(tpIntegra: '2', cNPJ: '12345678000123', tBand: 'Visa');
  /// String json = card.toJson();
  /// print(json); // Saída: {"tpIntegra":"2","cNPJ":"12345678000123","tBand":"Visa"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `CardPagamento` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string no formato JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `CardPagamento` inicializada com os dados fornecidos no JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"tpIntegra":"2","cNPJ":"12345678000123","tBand":"Visa"}';
  /// CardPagamento card = CardPagamento.fromJson(json);
  /// print(card.tBand); // Saída: Visa
  /// ```
  factory CardPagamento.fromJson(String source) =>
      CardPagamento.fromMap(json.decode(source));
}
