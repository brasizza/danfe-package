import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import 'danfe.dart';

///
/// Parser para onverter nosso XML em objeto
///
class DanfeParser {
  DanfeParser._();
  static Danfe? _parseDanfe(String xml) {
    final myTransformer = Xml2Json();
    myTransformer.parse(xml);
    String json = myTransformer.toParkerWithAttrs();
    Map<String, dynamic> _converter = jsonDecode(json);

    ///
    /// Verificando se começa com CFe ou nfeProc para saber se vai para  NFC-E ou SAT
    ///
    if (_converter.containsKey('CFe')) {
      return Danfe.fromMapSat(_converter['CFe']);
    } else if (_converter.containsKey('nfeProc')) {
      return Danfe.fromMapNFce(_converter['nfeProc']);
    }
    return null;
  }

  ///
  /// Metodo para isolar o parser
  ///
  static Danfe? readFromString(String xml) {
    return _parseDanfe(xml);
  }
}
