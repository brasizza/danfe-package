import 'dart:convert';

import 'package:xml2json/xml2json.dart';

import 'danfe.dart';

/// A classe `DanfeParser` fornece métodos utilitários para processar documentos XML
/// associados a DANFEs (Documento Auxiliar da Nota Fiscal Eletrônica) em objetos `Danfe`.
///
/// Essa classe utiliza a biblioteca `xml2json` para transformar o XML em JSON
/// e, em seguida, processar o JSON para criar instâncias de `Danfe`.
///
/// A classe é implementada com um construtor privado para garantir que não possa
/// ser instanciada diretamente, sendo usada apenas para acesso aos métodos estáticos.
class DanfeParser {
  /// Construtor privado para impedir a instanciação da classe.
  ///
  /// Essa abordagem é comum em classes utilitárias que fornecem apenas métodos estáticos.
  DanfeParser._();

  /// Método privado para analisar e converter um documento XML em um objeto `Danfe`.
  ///
  /// Este método realiza as seguintes etapas:
  /// 1. Usa a biblioteca `xml2json` para transformar o XML fornecido em um JSON no formato Parker.
  /// 2. Decodifica o JSON gerado em um `Map<String, dynamic>`.
  /// 3. Identifica a estrutura principal do documento (ex.: `CFe`, `nfeProc`, ou `NFe`)
  ///    e a mapeia para o modelo `Danfe` correspondente usando métodos específicos da classe `Danfe`.
  ///
  /// ### Parâmetros:
  /// - [xml]: Uma `String` contendo o documento XML que será analisado.
  ///
  /// ### Retorno:
  /// - Um objeto `Danfe` se o XML for compatível e puder ser convertido.
  /// - `null` se nenhuma estrutura reconhecida for encontrada no XML.
  ///
  /// ### Erros:
  /// - Pode lançar exceções relacionadas a parsing XML ou decodificação JSON
  ///   se o XML fornecido for inválido ou malformado.
  static Danfe? _parseDanfe(String xml) {
    final myTransformer = Xml2Json();
    myTransformer.parse(
      xml,
    ); // Transforma o XML em uma representação manipulável.
    String json = myTransformer
        .toParkerWithAttrs(); // Converte o XML para JSON no formato Parker.
    Map<String, dynamic> converter = jsonDecode(
      json,
    ); // Decodifica o JSON em um mapa.

    // Verifica as possíveis estruturas do XML e as converte em `Danfe`.
    if (converter.containsKey('CFe')) {
      return Danfe.fromMapSat(converter['CFe']);
    } else if (converter.containsKey('nfeProc')) {
      return Danfe.fromMapNFce(converter['nfeProc']);
    } else if (converter.containsKey('NFe')) {
      return Danfe.fromMapNFce(converter['NFe']);
    }

    // Retorna `null` se nenhuma estrutura conhecida for encontrada.
    return null;
  }

  /// Método público para converter um XML em um objeto `Danfe`.
  ///
  /// Esse método serve como uma interface de alto nível para `_parseDanfe`,
  /// encapsulando a lógica de parsing e retornando o objeto resultante.
  ///
  /// ### Parâmetros:
  /// - [xml]: Uma `String` contendo o documento XML que será processado.
  ///
  /// ### Retorno:
  /// - Um objeto `Danfe` se o XML for válido e puder ser convertido.
  /// - `null` se o XML não contiver uma estrutura reconhecida ou for malformado.
  static Danfe? readFromString(String xml) {
    return _parseDanfe(xml);
  }
}
