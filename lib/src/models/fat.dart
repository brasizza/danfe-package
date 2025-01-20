import 'dart:convert';

/// Classe que representa as informações da fatura.
///
/// Baseada no elemento `<fat>`.
class Fat {
  /// Número da fatura.
  String? nFat;

  /// Valor original da fatura.
  String? vOrig;

  /// Valor líquido da fatura.
  String? vLiq;

  /// Construtor da classe [Fat].
  Fat({
    this.nFat,
    this.vOrig,
    this.vLiq,
  });

  /// Converte a instância de [Fat] para um mapa.
  Map<String, dynamic> toMap() {
    return {
      'nFat': nFat,
      'vOrig': vOrig,
      'vLiq': vLiq,
    };
  }

  /// Cria uma instância de [Fat] a partir de um mapa.
  factory Fat.fromMap(Map<String, dynamic> map) {
    return Fat(
      nFat: map['nFat'],
      vOrig: map['vOrig'],
      vLiq: map['vLiq'],
    );
  }

  /// Converte a instância de [Fat] para uma string JSON.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de [Fat] a partir de uma string JSON.
  factory Fat.fromJson(String source) => Fat.fromMap(json.decode(source));
}
