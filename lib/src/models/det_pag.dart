import 'dart:convert';

import 'card_pagamento.dart';

class DetPag {
  String? tPag;
  String? vPag;
  CardPagamento? card;

  DetPag({this.tPag, this.vPag, this.card});

  Map<String, dynamic> toMap() {
    return {
      'tPag': tPag,
      'vPag': vPag,
      'card': card?.toMap(),
    };
  }

  factory DetPag.fromMap(Map<String, dynamic> map) {
    return DetPag(
      tPag: map['tPag'],
      vPag: map['vPag'],
      card: map['card'] != null ? CardPagamento.fromMap(map['card']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetPag.fromJson(String source) => DetPag.fromMap(json.decode(source));
}
