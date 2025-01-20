import 'dart:convert';

/// Classe que representa as informações do volume transportado.
///
/// Baseada no elemento `<vol>`.
class Vol {
  /// Quantidade de volumes.
  String? qVol;

  /// Marca dos volumes.
  String? marca;

  /// Numeração dos volumes.
  String? nVol;

  /// Peso líquido dos volumes.
  String? pesoL;

  /// Peso bruto dos volumes.
  String? pesoB;

  /// Construtor da classe [Vol].
  Vol({
    this.qVol,
    this.marca,
    this.nVol,
    this.pesoL,
    this.pesoB,
  });

  /// Converte a instância de [Vol] para um mapa.
  Map<String, dynamic> toMap() {
    return {
      'qVol': qVol,
      'marca': marca,
      'nVol': nVol,
      'pesoL': pesoL,
      'pesoB': pesoB,
    };
  }

  /// Cria uma instância de [Vol] a partir de um mapa.
  factory Vol.fromMap(Map<String, dynamic> map) {
    return Vol(
      qVol: map['qVol'],
      marca: map['marca'],
      nVol: map['nVol'],
      pesoL: map['pesoL'],
      pesoB: map['pesoB'],
    );
  }

  /// Converte a instância de [Vol] para uma string JSON.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de [Vol] a partir de uma string JSON.
  factory Vol.fromJson(String source) => Vol.fromMap(json.decode(source));
}
