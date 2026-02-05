/// Dados do serviço prestado.
class Servico {
  /// Local da prestação.
  LocalPrestacao? locPrest;

  /// Código do serviço.
  CodigoServico? cServ;

  /// Construtor.
  Servico({this.locPrest, this.cServ});

  /// Cria uma instância a partir de um Map.
  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      locPrest: map['locPrest'] != null
          ? LocalPrestacao.fromMap(map['locPrest'])
          : null,
      cServ: map['cServ'] != null ? CodigoServico.fromMap(map['cServ']) : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'locPrest': locPrest?.toMap(),
      'cServ': cServ?.toMap(),
    };
  }
}

/// Local da prestação do serviço.
class LocalPrestacao {
  /// Código do local de prestação.
  String? cLocPrestacao;

  /// Construtor.
  LocalPrestacao({this.cLocPrestacao});

  /// Cria uma instância a partir de um Map.
  factory LocalPrestacao.fromMap(Map<String, dynamic> map) {
    return LocalPrestacao(
      cLocPrestacao: map['cLocPrestacao'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'cLocPrestacao': cLocPrestacao,
    };
  }
}

/// Código e descrição do serviço.
class CodigoServico {
  /// Código de tributação nacional.
  String? cTribNac;

  /// Código de tributação municipal.
  String? cTribMun;

  /// Descrição do serviço.
  String? xDescServ;

  /// Código NBS.
  String? cNBS;

  /// Código de interesse do contribuinte.
  String? cIntContrib;

  /// Construtor.
  CodigoServico({
    this.cTribNac,
    this.cTribMun,
    this.xDescServ,
    this.cNBS,
    this.cIntContrib,
  });

  /// Cria uma instância a partir de um Map.
  factory CodigoServico.fromMap(Map<String, dynamic> map) {
    return CodigoServico(
      cTribNac: map['cTribNac'],
      cTribMun: map['cTribMun'],
      xDescServ: map['xDescServ'],
      cNBS: map['cNBS'],
      cIntContrib: map['cIntContrib'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'cTribNac': cTribNac,
      'cTribMun': cTribMun,
      'xDescServ': xDescServ,
      'cNBS': cNBS,
      'cIntContrib': cIntContrib,
    };
  }
}
