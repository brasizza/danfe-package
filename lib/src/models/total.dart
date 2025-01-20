// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// A classe `Total` representa os totais de valores em um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Cálculo automático de descontos e acréscimos com base na estrutura do mapa.
/// - Garantia de valores padrão para propriedades não fornecidas.
class Total {
  /// Valor total do documento.
  String? valorTotal;

  /// Valor total referente ao ICMS.
  String? valorTotalIcms;

  /// Valor total conforme Lei 12.741/2012 (transparência fiscal).
  String? valorLei12741;

  /// Valor do desconto aplicado ao documento.
  String? desconto;

  /// Valor do acréscimo aplicado ao documento.
  String? acrescimo;

  /// Valor total pago.
  String? valorPago;

  /// Construtor da classe `Total`.
  ///
  /// ### Parâmetros:
  /// - [valorTotal]: Valor total do documento.
  /// - [valorTotalIcms]: Valor total do ICMS.
  /// - [valorLei12741]: Valor conforme Lei 12.741/2012.
  /// - [desconto]: Valor do desconto aplicado.
  /// - [acrescimo]: Valor do acréscimo aplicado.
  /// - [valorPago]: Valor total pago.
  Total({
    this.valorTotal,
    this.valorTotalIcms,
    this.valorLei12741,
    this.desconto,
    this.acrescimo,
    this.valorPago,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `Total`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Total total = Total(valorTotal: '100.00', desconto: '5.00');
  /// Map<String, dynamic> mapa = total.toMap();
  /// print(mapa); // Saída: {valorTotal: 100.00, desconto: 5.00}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'valorTotal': valorTotal,
      'valorTotalIcms': valorTotalIcms,
      'valorLei12741': valorLei12741,
      'desconto': desconto,
      'acrescimo': acrescimo,
      'valorPago': valorPago,
    };
  }

  /// Cria uma instância de `Total` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `Total`.
  ///
  /// ### Retorno:
  /// - Uma instância de `Total` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'valorTotal': '100.00', 'desconto': '5.00'};
  /// Total total = Total.fromMap(mapa);
  /// print(total.valorTotal); // Saída: 100.00
  /// ```
  factory Total.fromMap(Map<String, dynamic> map) {
    final desconto = map['DescAcrEntr']?['vDescSubtot'] ??
        map['ICMSTot']?['vDesc'] ??
        '0.00';

    final acrescimo = map['DescAcrEntr']?['vAcresSubtot'] ??
        map['ICMSTot']?['vOutro'] ??
        '0.00';

    return Total(
      valorTotalIcms: map['ICMSTot']?['vProd'] ?? '0.00',
      valorTotal: map['vCFe'] ?? map['ICMSTot']?['vProd'] ?? '0.00',
      valorLei12741: map['vCFeLei12741'] ?? '0.00',
      desconto: desconto,
      acrescimo: acrescimo,
      valorPago: map['vCFe'] ?? map['ICMSTot']?['vNF'] ?? '0.00',
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `Total`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Total total = Total(valorTotal: '100.00', desconto: '5.00');
  /// String json = total.toJson();
  /// print(json); // Saída: {"valorTotal":"100.00","desconto":"5.00"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Total` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Total` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"valorTotal":"100.00","desconto":"5.00"}';
  /// Total total = Total.fromJson(json);
  /// print(total.desconto); // Saída: 5.00
  /// ```
  factory Total.fromJson(String source) => Total.fromMap(json.decode(source));
}
