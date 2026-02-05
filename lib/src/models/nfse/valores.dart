import 'tributos.dart';

/// Valores da NFSe.
class Valores {
  /// Valor do serviço prestado.
  ValorServicoPrestado? vServPrest;

  /// Tributos.
  Tributos? trib;

  /// Construtor.
  Valores({this.vServPrest, this.trib});

  /// Cria uma instância a partir de um Map.
  factory Valores.fromMap(Map<String, dynamic> map) {
    return Valores(
      vServPrest: map['vServPrest'] != null
          ? ValorServicoPrestado.fromMap(map['vServPrest'])
          : null,
      trib: map['trib'] != null ? Tributos.fromMap(map) : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'vServPrest': vServPrest?.toMap(),
      'trib': trib?.toMap(),
    };
  }
}

/// Valor do serviço prestado.
class ValorServicoPrestado {
  /// Valor do serviço.
  String? vServ;

  /// Valor das deduções.
  String? vDed;

  /// Valor da base de cálculo.
  String? vBC;

  /// Construtor.
  ValorServicoPrestado({this.vServ, this.vDed, this.vBC});

  /// Cria uma instância a partir de um Map.
  factory ValorServicoPrestado.fromMap(Map<String, dynamic> map) {
    return ValorServicoPrestado(
      vServ: map['vServ'],
      vDed: map['vDed'],
      vBC: map['vBC'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'vServ': vServ,
      'vDed': vDed,
      'vBC': vBC,
    };
  }
}
