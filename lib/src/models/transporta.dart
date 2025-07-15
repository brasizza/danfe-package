import 'dart:convert';

/// Classe que representa as informações do transportador.
///
/// Baseada no elemento `<transporta>`.
class Transporta {
  /// Nome do transportador.
  String? xNome;

  /// Endereço do transportador.
  String? xEnder;

  /// Município do transportador.
  String? xMun;

  /// Unidade Federativa do transportador.
  String? uf;

  /// Construtor da classe [Transporta].
  Transporta({this.xNome, this.xEnder, this.xMun, this.uf});

  /// Converte a instância de [Transporta] para um mapa.
  Map<String, dynamic> toMap() {
    return {'xNome': xNome, 'xEnder': xEnder, 'xMun': xMun, 'UF': uf};
  }

  /// Cria uma instância de [Transporta] a partir de um mapa.
  factory Transporta.fromMap(Map<String, dynamic> map) {
    return Transporta(
      xNome: map['xNome'],
      xEnder: map['xEnder'],
      xMun: map['xMun'],
      uf: map['UF'],
    );
  }

  /// Converte a instância de [Transporta] para uma string JSON.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de [Transporta] a partir de uma string JSON.
  factory Transporta.fromJson(String source) =>
      Transporta.fromMap(json.decode(source));
}
