import 'dart:convert';

class MP {
  String? cMP;
  String? vMP;
  MP({this.cMP, this.vMP});

  Map<String, dynamic> toMap() {
    return {
      'cMP': cMP,
      'vMP': vMP,
    };
  }

  factory MP.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> formasPagamento = {
      "10": "Vale Alimentacao",
      "11": "Vale Refeicao",
      "12": "Vale Presente",
      "13": "Vale Combustivel",
      "14": "Duplicata Mercantil",
      "15": "Boleto Bancario",
      "16": "Depósito Bancário",
      "17": "PIX",
      "18": "Transferência bancária, Carteira Digital",
      "19": "Cashback, Cartão Fidelidade",
      "90": "Sem Pagamento",
      "99": "Outros",
      "01": "Dinheiro",
      "02": "Cheque",
      "03": "Cartao de Credito",
      "04": "Cartao de Debito",
      "05": "Credito Loja",
    };
    return MP(
      cMP: (map.containsKey('cMP'))
          ? formasPagamento[map['cMP']]
          : formasPagamento[map['tPag']],
      vMP: (map.containsKey('vMP')) ? map['vMP'] : map['vPag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MP.fromJson(String source) => MP.fromMap(json.decode(source));
}
