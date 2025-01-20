import 'dart:convert';

/// Classe que representa as informações de duplicatas.
///
/// Baseada no elemento `<dup>`.
class Dup {
  /// Número da duplicata.
  String? nDup;

  /// Data de vencimento da duplicata.
  String? dVenc;

  /// Valor da duplicata.
  String? vDup;

  /// Construtor da classe [Dup].
  Dup({
    this.nDup,
    this.dVenc,
    this.vDup,
  });

  /// Converte a instância de [Dup] para um mapa.
  Map<String, dynamic> toMap() {
    return {
      'nDup': nDup,
      'dVenc': dVenc,
      'vDup': vDup,
    };
  }

  /// Cria uma instância de [Dup] a partir de um mapa.
  factory Dup.fromMap(Map<String, dynamic> map) {
    return Dup(
      nDup: map['nDup'],
      dVenc: map['dVenc'],
      vDup: map['vDup'],
    );
  }

  /// Converte a instância de [Dup] para uma string JSON.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de [Dup] a partir de uma string JSON.
  factory Dup.fromJson(String source) => Dup.fromMap(json.decode(source));
}
