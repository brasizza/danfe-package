import 'dart:convert';

/// A classe `MP` representa uma forma de pagamento em uma Nota Fiscal Eletrônica (NFe).
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Mapeamento de códigos para descrições de formas de pagamento.
class MP {
  /// Código da forma de pagamento.
  String? cMP;

  /// Valor associado à forma de pagamento.
  String? vMP;

  /// Construtor da classe `MP`.
  ///
  /// ### Parâmetros:
  /// - [cMP]: Código da forma de pagamento.
  /// - [vMP]: Valor da forma de pagamento.
  MP({this.cMP, this.vMP});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `MP`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// MP mp = MP(cMP: '01', vMP: '100.00');
  /// Map<String, dynamic> mapa = mp.toMap();
  /// print(mapa); // Saída: {cMP: 01, vMP: 100.00}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'cMP': cMP,
      'vMP': vMP,
    };
  }

  /// Cria uma instância de `MP` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `MP`.
  ///
  /// ### Retorno:
  /// - Uma instância de `MP` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'cMP': '01', 'vMP': '100.00'};
  /// MP mp = MP.fromMap(mapa);
  /// print(mp.cMP); // Saída: 01
  /// ```
  factory MP.fromMap(Map<String, dynamic> map) {
    final Map<String, String> formasPagamento = {
      "01": "Dinheiro",
      "02": "Cheque",
      "03": "Cartão de Crédito",
      "04": "Cartão de Débito",
      "05": "Crédito Loja",
      "10": "Vale Alimentação",
      "11": "Vale Refeição",
      "12": "Vale Presente",
      "13": "Vale Combustível",
      "14": "Duplicata Mercantil",
      "15": "Boleto Bancário",
      "16": "Depósito Bancário",
      "17": "PIX",
      "18": "Transferência Bancária, Carteira Digital",
      "19": "Cashback, Cartão Fidelidade",
      "20": "Programas de Pontos",
      "21": "Crédito Virtual",
      "90": "Sem Pagamento",
      "99": "Outros",
    };

    return MP(
      cMP: formasPagamento[map['cMP']] ?? formasPagamento[map['tPag']],
      vMP: map['vMP'] ?? map['vPag'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `MP`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// MP mp = MP(cMP: '01', vMP: '100.00');
  /// String json = mp.toJson();
  /// print(json); // Saída: {"cMP":"01","vMP":"100.00"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `MP` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `MP` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"cMP":"01","vMP":"100.00"}';
  /// MP mp = MP.fromJson(json);
  /// print(mp.cMP); // Saída: 01
  /// ```
  factory MP.fromJson(String source) => MP.fromMap(json.decode(source));
}
