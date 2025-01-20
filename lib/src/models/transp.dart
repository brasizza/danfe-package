import 'dart:convert';

import 'package:danfe/src/models/transporta.dart';
import 'package:danfe/src/models/vol.dart';

/// Classe que representa as informações de transporte da nota fiscal.
///
/// Baseada no XML do elemento `<transp>`.
class Transp {
  /// Modalidade do frete.
  String? modFrete;

  /// Informações do transportador.
  Transporta? transporta;

  /// Informações do volume transportado.
  Vol? vol;

  /// Construtor da classe [Transp].
  ///
  /// Recebe:
  /// - [modFrete]: Modalidade do frete.
  /// - [transporta]: Informações do transportador.
  /// - [vol]: Informações do volume transportado.
  Transp({
    this.modFrete,
    this.transporta,
    this.vol,
  });

  /// Converte a instância de [Transp] para um mapa.
  Map<String, dynamic> toMap() {
    return {
      'modFrete': modFrete,
      'transporta': transporta?.toMap(),
      'vol': vol?.toMap(),
    };
  }

  /// Cria uma instância de [Transp] a partir de um mapa.
  factory Transp.fromMap(Map<String, dynamic> map) {
    return Transp(
      modFrete: map['modFrete'],
      transporta: map['transporta'] != null
          ? Transporta.fromMap(map['transporta'])
          : null,
      vol: map['vol'] != null ? Vol.fromMap(map['vol']) : null,
    );
  }

  /// Converte a instância de [Transp] para uma string JSON.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de [Transp] a partir de uma string JSON.
  factory Transp.fromJson(String source) => Transp.fromMap(json.decode(source));
}
