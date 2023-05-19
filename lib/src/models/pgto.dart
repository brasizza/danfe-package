import 'dart:convert';

import 'mp.dart';

class Pgto {
  List<MP>? formas;
  String? vTroco;
  Pgto({this.formas, this.vTroco});

  Map<String, dynamic> toMap() {
    return {
      'MP': formas?.map((x) => x.toMap()).toList(),
      'vTroco': vTroco,
    };
  }

  factory Pgto.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('MP')) {
      final List<MP> listMP = [];

      if (map['MP'].runtimeType.toString() != 'List<dynamic>') {
        listMP.add(MP.fromMap(map['MP']));
      } else {
        listMP.addAll(List<MP>.from(map['MP']?.map((x) => MP.fromMap(x))));
      }
      return Pgto(
        formas: map['MP'] != null ? listMP : null,
        vTroco: map['vTroco'],
      );
    } else if (map.containsKey('detPag')) {
      final listMP = [MP.fromMap(map['detPag'])];
      return Pgto(
        formas: map['detPag'] != null ? listMP : null,
        vTroco: map['vTroco'],
      );
    } else {
      return Pgto();
    }
  }

  String toJson() => json.encode(toMap());

  factory Pgto.fromJson(String source) => Pgto.fromMap(json.decode(source));
}
