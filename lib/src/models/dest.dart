import 'dart:convert';

/// A classe `Dest` representa os dados do destinatário de um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
class Dest {
  /// CPF do destinatário (se aplicável).
  String? cpf;

  /// CNPJ do destinatário (se aplicável).
  String? cnpj;

  /// Nome do destinatário.
  String? xNome;

  /// Construtor da classe `Dest`.
  ///
  /// ### Parâmetros:
  /// - [cpf]: CPF do destinatário.
  /// - [cnpj]: CNPJ do destinatário.
  /// - [xNome]: Nome do destinatário.
  Dest({this.cpf, this.xNome, this.cnpj});

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades do destinatário.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Dest dest = Dest(cpf: '12345678901', xNome: 'Fulano de Tal');
  /// Map<String, dynamic> mapa = dest.toMap();
  /// print(mapa); // Saída: {cpf: 12345678901, xNome: Fulano de Tal}
  /// ```
  Map<String, dynamic> toMap() {
    return {'cpf': cpf, 'cnpj': cnpj, 'xNome': xNome};
  }

  /// Cria uma instância de `Dest` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades do destinatário.
  ///
  /// ### Retorno:
  /// - Uma instância de `Dest` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'CPF': '12345678901', 'xNome': 'Fulano de Tal'};
  /// Dest dest = Dest.fromMap(mapa);
  /// print(dest.xNome); // Saída: Fulano de Tal
  /// ```
  factory Dest.fromMap(Map<String, dynamic> map) {
    return Dest(cpf: map['CPF'], cnpj: map['CNPJ'], xNome: map['xNome']);
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados do destinatário.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Dest dest = Dest(cpf: '12345678901', xNome: 'Fulano de Tal');
  /// String json = dest.toJson();
  /// print(json); // Saída: {"cpf":"12345678901","xNome":"Fulano de Tal"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Dest` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Dest` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"CPF":"12345678901","xNome":"Fulano de Tal"}';
  /// Dest dest = Dest.fromJson(json);
  /// print(dest.cpf); // Saída: 12345678901
  /// ```
  factory Dest.fromJson(String source) => Dest.fromMap(json.decode(source));
}
