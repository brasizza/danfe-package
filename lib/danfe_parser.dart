import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import 'danfe.dart';

class DanfeParser {
  DanfeParser._();
  static Danfe? parseDanfe(String xml) {
    final myTransformer = Xml2Json();
    myTransformer.parse(xml);
// Transform to JSON using Badgerfish
    String json = myTransformer.toParkerWithAttrs();
    Map<String, dynamic> _converter = jsonDecode(json);
    if (_converter.containsKey('CFe')) {
      return Danfe.fromMapSat(_converter['CFe']);
    } else if (_converter.containsKey('nfeProc')) {
      return Danfe.fromMapNFce(_converter['nfeProc']);
    }
    return null;
  }

  Danfe? readFromString(String xml) {
    return parseDanfe(xml);
  }
}
