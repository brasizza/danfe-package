import 'dart:convert';

class Dest {
  String? cpf;
  String? cnpj;
  String? xNome;
  Dest({this.cpf, this.xNome, this.cnpj});

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'xNome': xNome,
    };
  }

  factory Dest.fromMap(Map<String, dynamic> map) {
    return Dest(
      cpf: map['CPF'],
      cnpj: map['CNPJ'],
      xNome: map['xNome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dest.fromJson(String source) => Dest.fromMap(json.decode(source));
}
