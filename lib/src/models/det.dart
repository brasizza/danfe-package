import 'dart:convert';

import 'prod.dart';

class Det {
  Prod? prod;
  String? sNItem;
  Det({this.prod, this.sNItem});

  Map<String, dynamic> toMap() {
    return {
      'prod': prod?.toMap(),
      'sNItem': sNItem,
    };
  }

  factory Det.fromMap(Map<String, dynamic> map) {
    return Det(
      prod: map['prod'] != null ? Prod.fromMap(map['prod']) : null,
      sNItem: map['_nItem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Det.fromJson(String source) => Det.fromMap(json.decode(source));
}
