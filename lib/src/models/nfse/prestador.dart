/// Dados do prestador de serviços.
class Prestador {
  /// CNPJ do prestador.
  String? cnpj;

  /// CPF do prestador (alternativo ao CNPJ).
  String? cpf;

  /// Regime tributário.
  RegimeTributario? regTrib;

  /// Construtor.
  Prestador({this.cnpj, this.cpf, this.regTrib});

  /// Cria uma instância a partir de um Map.
  factory Prestador.fromMap(Map<String, dynamic> map) {
    return Prestador(
      cnpj: map['CNPJ'],
      cpf: map['CPF'],
      regTrib: map['regTrib'] != null
          ? RegimeTributario.fromMap(map['regTrib'])
          : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'CNPJ': cnpj,
      'CPF': cpf,
      'regTrib': regTrib?.toMap(),
    };
  }
}

/// Regime tributário do prestador.
class RegimeTributario {
  /// Opção do Simples Nacional (1-Sim, 2-Não).
  String? opSimpNac;

  /// Regime especial de tributação.
  String? regEspTrib;

  /// Construtor.
  RegimeTributario({this.opSimpNac, this.regEspTrib});

  /// Cria uma instância a partir de um Map.
  factory RegimeTributario.fromMap(Map<String, dynamic> map) {
    return RegimeTributario(
      opSimpNac: map['opSimpNac'],
      regEspTrib: map['regEspTrib'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'opSimpNac': opSimpNac,
      'regEspTrib': regEspTrib,
    };
  }
}
