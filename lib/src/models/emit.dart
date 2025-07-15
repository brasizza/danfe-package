import 'dart:convert';

import 'ender_emit.dart';

/// A classe `Emit` representa os dados do emitente de um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class Emit {
  /// CNPJ do emitente.
  String? cnpj;

  /// Nome do emitente.
  String? xNome;

  /// Nome fantasia do emitente.
  String? xFant;

  /// Inscrição Estadual do emitente.
  String? iE;

  /// Inscrição Municipal do emitente.
  String? iM;

  /// Código de Regime Tributário.
  String? cRegTrib;

  /// Indicador de rateio do ISSQN.
  String? indRatISSQN;

  /// Endereço do emitente.
  EnderEmit? enderEmit;

  /// Construtor da classe `Emit`.
  ///
  /// ### Parâmetros:
  /// - [cnpj]: CNPJ do emitente.
  /// - [xNome]: Nome do emitente.
  /// - [xFant]: Nome fantasia do emitente.
  /// - [iE]: Inscrição Estadual do emitente.
  /// - [iM]: Inscrição Municipal do emitente.
  /// - [cRegTrib]: Código de Regime Tributário.
  /// - [indRatISSQN]: Indicador de rateio do ISSQN.
  /// - [enderEmit]: Endereço do emitente.
  Emit({
    this.cnpj,
    this.xNome,
    this.xFant,
    this.iE,
    this.iM,
    this.cRegTrib,
    this.indRatISSQN,
    this.enderEmit,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `Emit`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Emit emit = Emit(cnpj: '12345678000123', xNome: 'Empresa X');
  /// Map<String, dynamic> mapa = emit.toMap();
  /// print(mapa); // Saída: {cnpj: 12345678000123, xNome: Empresa X}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
      'xNome': xNome,
      'xFant': xFant,
      'iE': iE,
      'iM': iM,
      'cRegTrib': cRegTrib,
      'indRatISSQN': indRatISSQN,
      'enderEmit': enderEmit?.toMap(),
    };
  }

  /// Cria uma instância de `Emit` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `Emit`.
  ///
  /// ### Retorno:
  /// - Uma instância de `Emit` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'CNPJ': '12345678000123', 'xNome': 'Empresa X'};
  /// Emit emit = Emit.fromMap(mapa);
  /// print(emit.xNome); // Saída: Empresa X
  /// ```
  factory Emit.fromMap(Map<String, dynamic> map) {
    return Emit(
      cnpj: map['CNPJ'],
      xNome: map['xNome'],
      xFant: map['xFant'],
      iE: map['IE'],
      iM: map['IM'],
      cRegTrib: map['cRegTrib'],
      indRatISSQN: map['indRatISSQN'],
      enderEmit: map['enderEmit'] != null
          ? EnderEmit.fromMap(map['enderEmit'])
          : null,
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `Emit`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Emit emit = Emit(cnpj: '12345678000123', xNome: 'Empresa X');
  /// String json = emit.toJson();
  /// print(json); // Saída: {"cnpj":"12345678000123","xNome":"Empresa X"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Emit` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Emit` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"CNPJ":"12345678000123","xNome":"Empresa X"}';
  /// Emit emit = Emit.fromJson(json);
  /// print(emit.cnpj); // Saída: 12345678000123
  /// ```
  factory Emit.fromJson(String source) => Emit.fromMap(json.decode(source));
}
