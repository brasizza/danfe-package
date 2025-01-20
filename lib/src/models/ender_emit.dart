import 'dart:convert';

/// A classe `EnderEmit` representa o endereço do emitente em um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class EnderEmit {
  /// Logradouro do emitente.
  String? xLgr;

  /// Número do logradouro.
  String? nro;

  /// Complemento do endereço.
  String? xCpl;

  /// Bairro do emitente.
  String? xBairro;

  /// Código do município (IBGE).
  String? cMun;

  /// Nome do município.
  String? xMun;

  /// Unidade Federativa (UF).
  String? uF;

  /// Código postal (CEP).
  String? cEP;

  /// Código do país.
  String? cPais;

  /// Nome do país.
  String? xPais;

  /// Telefone do emitente.
  String? fone;

  /// Construtor da classe `EnderEmit`.
  ///
  /// ### Parâmetros:
  /// - [xLgr]: Logradouro.
  /// - [nro]: Número do logradouro.
  /// - [xCpl]: Complemento do endereço.
  /// - [xBairro]: Bairro do emitente.
  /// - [cMun]: Código do município (IBGE).
  /// - [xMun]: Nome do município.
  /// - [uF]: Unidade Federativa (UF).
  /// - [cEP]: Código postal (CEP).
  /// - [cPais]: Código do país.
  /// - [xPais]: Nome do país.
  /// - [fone]: Telefone do emitente.
  EnderEmit({
    this.xLgr,
    this.nro,
    this.xCpl,
    this.xBairro,
    this.cMun,
    this.xMun,
    this.uF,
    this.cEP,
    this.cPais,
    this.xPais,
    this.fone,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `EnderEmit`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// EnderEmit endereco = EnderEmit(xLgr: 'Rua A', nro: '123');
  /// Map<String, dynamic> mapa = endereco.toMap();
  /// print(mapa); // Saída: {xLgr: Rua A, nro: 123}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'xLgr': xLgr,
      'nro': nro,
      'xCpl': xCpl,
      'xBairro': xBairro,
      'cMun': cMun,
      'xMun': xMun,
      'uF': uF,
      'cEP': cEP,
      'cPais': cPais,
      'xPais': xPais,
      'fone': fone,
    };
  }

  /// Cria uma instância de `EnderEmit` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `EnderEmit`.
  ///
  /// ### Retorno:
  /// - Uma instância de `EnderEmit` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'xLgr': 'Rua A', 'nro': '123'};
  /// EnderEmit endereco = EnderEmit.fromMap(mapa);
  /// print(endereco.xLgr); // Saída: Rua A
  /// ```
  factory EnderEmit.fromMap(Map<String, dynamic> map) {
    return EnderEmit(
      xLgr: map['xLgr'],
      nro: map['nro'],
      xCpl: map['xCpl'],
      xBairro: map['xBairro'],
      cMun: map['cMun'],
      xMun: map['xMun'],
      uF: map['UF'],
      cEP: map['CEP'],
      cPais: map['cPais'],
      xPais: map['xPais'],
      fone: map['fone'],
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `EnderEmit`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// EnderEmit endereco = EnderEmit(xLgr: 'Rua A', nro: '123');
  /// String json = endereco.toJson();
  /// print(json); // Saída: {"xLgr":"Rua A","nro":"123"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `EnderEmit` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `EnderEmit` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"xLgr":"Rua A","nro":"123"}';
  /// EnderEmit endereco = EnderEmit.fromJson(json);
  /// print(endereco.nro); // Saída: 123
  /// ```
  factory EnderEmit.fromJson(String source) =>
      EnderEmit.fromMap(json.decode(source));
}
