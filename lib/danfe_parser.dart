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
    Map<String, dynamic> converter = jsonDecode(json);

    ///
    /// Verificando se começa com CFe ou nfeProc para saber se vai para  NFC-E ou SAT
    ///
    if (converter.containsKey('CFe')) {
      return Danfe.fromMapSat(converter['CFe']);
    } else if (converter.containsKey('nfeProc')) {
      return Danfe.fromMapNFce(converter['nfeProc']);
    } else if (converter.containsKey('NFe')) {
      return Danfe.fromMapNFce(converter['NFe']);
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
