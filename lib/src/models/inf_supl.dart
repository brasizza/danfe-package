import 'dart:convert';

class InfNFeSupl {
  String? qrCode;
  String? urlChave;

  InfNFeSupl({
    this.qrCode,
    this.urlChave,
  });

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrCode,
      'urlChave': urlChave,
    };
  }

  factory InfNFeSupl.fromMap(Map<String, dynamic> map) {
    return InfNFeSupl(
      qrCode: map['qrCode'],
      urlChave: map['urlChave'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfNFeSupl.fromJson(String source) =>
      InfNFeSupl.fromMap(json.decode(source));
}
