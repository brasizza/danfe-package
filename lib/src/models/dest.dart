import 'dart:convert';

class Dest {
  String? cpf;
  String? xNome;
  Dest({this.cpf, this.xNome});

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'xNome': xNome,
    };
  }

  factory Dest.fromMap(Map<String, dynamic> map) {
    return Dest(
      cpf: map['CPF'],
      xNome: map['xNome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dest.fromJson(String source) => Dest.fromMap(json.decode(source));
}
