/// Tributos aplicados.
class Tributos {
  /// Tributos municipais.
  TributoMunicipal? tribMun;

  /// Tributos federais.
  TributoFederal? tribFed;

  /// Total de tributos.
  TotalTributo? totTrib;

  /// Construtor.
  Tributos({this.tribMun, this.tribFed, this.totTrib});

  /// Cria uma instância a partir de um Map.
  factory Tributos.fromMap(Map<String, dynamic> map) {
    return Tributos(
      tribMun: map['trib']['tribMun'] != null
          ? TributoMunicipal.fromMap(map)
          : null,
      tribFed: map['trib']['tribFed'] != null
          ? TributoFederal.fromMap(map['trib'])
          : null,
      totTrib: map['trib']['totTrib'] != null
          ? TotalTributo.fromMap(map)
          : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'tribMun': tribMun?.toMap(),
      'tribFed': tribFed?.toMap(),
      'totTrib': totTrib?.toMap(),
    };
  }
}

/// Tributo municipal (ISSQN).
class TributoMunicipal {
  /// Tributação do ISSQN (1-Sim, 2-Não).
  String? tribISSQN;

  /// Tipo de retenção do ISSQN.
  String? tpRetISSQN;

  /// Alíquota percentual.
  String? pAliq;

  /// Valor do ISSQN.
  String? vISSQN;

  /// Construtor.
  TributoMunicipal({this.tribISSQN, this.tpRetISSQN, this.pAliq, this.vISSQN});

  /// Cria uma instância a partir de um Map.
  factory TributoMunicipal.fromMap(Map<String, dynamic> mapMun) {
    final map = mapMun['trib']['tribMun'] ?? mapMun;
    return TributoMunicipal(
      tribISSQN: map['tribISSQN'],
      tpRetISSQN: map['tpRetISSQN'],
      pAliq: mapMun['pAliqAplic'] ?? map['pAliq'],
      vISSQN: mapMun['vISSQN'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'tribISSQN': tribISSQN,
      'tpRetISSQN': tpRetISSQN,
      'pAliq': pAliq,
      'vISSQN': vISSQN,
    };
  }
}

/// Tributo federal (PIS/COFINS).
class TributoFederal {
  /// PIS/COFINS.
  PisCofins? piscofins;

  /// Construtor.
  TributoFederal({this.piscofins});

  /// Cria uma instância a partir de um Map.
  factory TributoFederal.fromMap(Map<String, dynamic> mapFed) {
    final map = mapFed['tribFed'] ?? mapFed;
    return TributoFederal(
      piscofins: map['piscofins'] != null
          ? PisCofins.fromMap(map['piscofins'])
          : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'piscofins': piscofins?.toMap(),
    };
  }
}

/// PIS/COFINS.
class PisCofins {
  /// CST (Código de Situação Tributária).
  String? cst;

  /// Valor do PIS.
  String? vPIS;

  /// Valor do COFINS.
  String? vCOFINS;

  /// Construtor.
  PisCofins({this.cst, this.vPIS, this.vCOFINS});

  /// Cria uma instância a partir de um Map.
  factory PisCofins.fromMap(Map<String, dynamic> map) {
    return PisCofins(
      cst: map['CST'] ?? map['cst'],
      vPIS: map['vPIS'],
      vCOFINS: map['vCOFINS'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'CST': cst,
      'vPIS': vPIS,
      'vCOFINS': vCOFINS,
    };
  }
}

/// Total de tributos.
class TotalTributo {
  /// Indicador de total de tributos (0-Não informado, 1-Informado).
  String? indTotTrib;

  /// Valor total aproximado dos tributos.
  String? vTotTrib;

  /// Construtor.
  TotalTributo({this.indTotTrib, this.vTotTrib});

  /// Cria uma instância a partir de um Map.
  factory TotalTributo.fromMap(Map<String, dynamic> mapTrib) {
    final map = mapTrib['trib']['totTrib'] ?? mapTrib;
    return TotalTributo(
      indTotTrib: map['indTotTrib'],
      vTotTrib: mapTrib['vISSQN'] ?? mapTrib['vTotTrib'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'indTotTrib': indTotTrib,
      'vTotTrib': vTotTrib,
    };
  }
}
