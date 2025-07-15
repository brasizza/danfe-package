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

  ///Valor ICMS
  String? valorIcms;

  ///Valor Frete
  String? valorFrete;

  ///Valor Pis
  String? valorPis;

  ///Valor Cofins
  String? valorCofins;

  ///ValorIpi
  String? valorIpi;

  ///Valor Substituicao Tributária
  String? valorSt;
  //Valor total de tributação
  String? valotTotalTributos;

  //Valor da base de calculo
  String? valorBaseCalculo;

  String? valorIcmsDesonerado;
  String? valorBaseCalculoSt;
  String? valorSeguro;

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
    this.valorCofins,
    this.valorFrete,
    this.valorIcms,
    this.valorPis,
    this.valorIpi,
    this.valorSt,
    this.valotTotalTributos,
    this.valorBaseCalculo,
    this.valorBaseCalculoSt,
    this.valorIcmsDesonerado,
    this.valorSeguro,
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
      'valorCofins': valorCofins,
      'valorFrete': valorFrete,
      'valorIcms': valorIcms,
      'valorPis': valorPis,
      'valorIpi': valorIpi,
      'valorSt': valorSt,
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
    final desconto =
        map['DescAcrEntr']?['vDescSubtot'] ??
        map['ICMSTot']?['vDesc'] ??
        '0.00';

    final acrescimo =
        map['DescAcrEntr']?['vAcresSubtot'] ??
        map['ICMSTot']?['vOutro'] ??
        '0.00';

    return Total(
      valorLei12741: map['vCFeLei12741'] ?? '0.00',
      valorBaseCalculo: map['ICMSTot']?['vBC'] ?? '0.00',
      valorTotalIcms: map['ICMSTot']?['vICMS'] ?? '0.00',
      valorIcmsDesonerado: map['ICMSTot']?['vICMSDeson'] ?? '0.00',
      valorBaseCalculoSt: map['ICMSTot']?['vBCST'] ?? '0.00',
      valorSt: map['ICMSTot']?['vSt'] ?? '0.00',
      valorTotal: map['vCFe'] ?? map['ICMSTot']?['vProd'] ?? '0.00',
      valorFrete: map['ICMSTot']?['vFrete'] ?? '0.00',
      valorSeguro: map['ICMSTot']?['vSeg'] ?? '0.00',
      desconto: desconto,
      valorIpi: map['ICMSTot']?['vIPI'] ?? '0.00',
      valorPis: map['ICMSTot']?['vPIS'] ?? '0.00',
      valorCofins: map['ICMSTot']?['vCOFINS'] ?? '0.00',
      acrescimo: acrescimo,
      valorPago: map['vCFe'] ?? map['ICMSTot']?['vNF'] ?? '0.00',
      valorIcms: map['ICMSTot']?['vICMS'] ?? '0.00',
      valotTotalTributos: map['ICMSTot']?['valotTotalTributos'] ?? '0.00',
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
