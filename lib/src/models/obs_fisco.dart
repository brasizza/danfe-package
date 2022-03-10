import 'dart:convert';

class ObsFisco {
  String? xTexto;
  String? sXCampo;
  ObsFisco({this.xTexto, this.sXCampo});

  Map<String, dynamic> toMap() {
    return {
      'xTexto': xTexto,
      'sXCampo': sXCampo,
    };
  }

  factory ObsFisco.fromMap(Map<String, dynamic> map) {
    return ObsFisco(
      xTexto: map['xTexto'],
      sXCampo: map['sXCampo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ObsFisco.fromJson(String source) =>
      ObsFisco.fromMap(json.decode(source));
}
