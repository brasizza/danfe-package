import 'dart:convert';

import 'obs_fisco.dart';

class InfAdic {
  String? infCpl;
  ObsFisco? obsFisco;
  InfAdic({this.infCpl, this.obsFisco});

  Map<String, dynamic> toMap() {
    return {
      'infCpl': infCpl,
      'obsFisco': obsFisco?.toMap(),
    };
  }

  factory InfAdic.fromMap(Map<String, dynamic> map) {
    return InfAdic(
      infCpl: map['infCpl'],
      obsFisco:
          map['obsFisco'] != null ? ObsFisco.fromMap(map['obsFisco']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfAdic.fromJson(String source) =>
      InfAdic.fromMap(json.decode(source));
}
