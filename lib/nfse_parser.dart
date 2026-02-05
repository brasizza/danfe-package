import 'package:xml/xml.dart';

import 'src/models/nfse/nfse.dart';

/// A classe `NfseParser` fornece métodos utilitários para processar documentos XML
/// de NFSe (Nota Fiscal de Serviços Eletrônica) Nacional em objetos `Nfse`.
///
/// Essa classe utiliza a biblioteca `xml` para processar o XML e converte
/// os dados em instâncias de `Nfse`.
///
/// A classe é implementada com um construtor privado para garantir que não possa
/// ser instanciada diretamente, sendo usada apenas para acesso aos métodos estáticos.
class NfseParser {
  /// Construtor privado para impedir a instanciação da classe.
  ///
  /// Essa abordagem é comum em classes utilitárias que fornecem apenas métodos estáticos.
  NfseParser._();

  /// Método privado para analisar e converter um documento XML em um objeto `Nfse`.
  ///
  /// Este método realiza as seguintes etapas:
  /// 1. Faz o parse do XML fornecido.
  /// 2. Verifica se é uma NFSe Nacional (baseado no versaoAplicativo contendo "Nacional").
  /// 3. Converte a estrutura XML em um Map recursivamente.
  /// 4. Cria uma instância de `Nfse` a partir do Map.
  ///
  /// ### Parâmetros:
  /// - [xml]: Uma `String` contendo o documento XML que será analisado.
  ///
  /// ### Retorno:
  /// - Um objeto `Nfse` se o XML for compatível (NFSe Nacional).
  /// - `null` se o XML não for uma NFSe Nacional ou for inválido.
  static Nfse? _parseNfse(String xml) {
    try {
      final document = XmlDocument.parse(xml);

      // Verifica se é NFSe Nacional pelo versaoAplicativo
      if (!_isNfseNacional(document)) {
        return null;
      }

      // Procura o elemento infNFSe primeiro (contém dados gerais da NFSe)
      final infNFSeElements = document.findAllElements('infNFSe');

      Map<String, dynamic> nfseMap = {};

      // Se encontrou infNFSe, pega os dados dele
      if (infNFSeElements.isNotEmpty) {
        final infNFSeElement = infNFSeElements.first;
        nfseMap = _xmlToMap(infNFSeElement);
      }

      // Procura o elemento DPS (pode estar dentro de infNFSe ou separado)
      final dpsElements = document.findAllElements('DPS');
      if (dpsElements.isNotEmpty) {
        final dpsElement = dpsElements.first;
        final dpsMap = _xmlToMap(dpsElement);

        // Mescla os dados do DPS no mapa da NFSe
        nfseMap.addAll(dpsMap);
      }

      return Nfse.fromMap(nfseMap);
    } catch (e) {
      // Retorna null em caso de erro
      return null;
    }
  }

  /// Verifica se o XML é uma NFSe Nacional.
  ///
  /// ### Critérios:
  /// - Deve ter o campo `versaoAplicativo` contendo "Nacional" (ex: "SefinNacional_1.5.0").
  ///
  /// ### Parâmetros:
  /// - [document]: Documento XML parseado.
  ///
  /// ### Retorno:
  /// - `true` se for NFSe Nacional.
  /// - `false` caso contrário.
  static bool _isNfseNacional(XmlDocument document) {
    try {
      // Procura pelo elemento versaoAplicativo
      final versaoElements = document.findAllElements('versaoAplicativo');

      if (versaoElements.isEmpty) {
        return false;
      }

      final versao = versaoElements.first.innerText;

      // Verifica se contém "Nacional" (case insensitive)
      return versao.toLowerCase().contains('nacional');
    } catch (e) {
      return false;
    }
  }

  /// Converte um elemento XML em um Map recursivamente.
  ///
  /// ### Parâmetros:
  /// - [element]: Elemento XML a ser convertido.
  ///
  /// ### Retorno:
  /// - Um `Map<String, dynamic>` representando a estrutura do XML.
  static Map<String, dynamic> _xmlToMap(XmlElement element) {
    final map = <String, dynamic>{};

    // Adiciona os atributos do elemento
    for (var attribute in element.attributes) {
      map['@${attribute.name.local}'] = attribute.value;
    }

    // Agrupa elementos filhos por nome
    final childrenByName = <String, List<XmlElement>>{};

    for (var node in element.children) {
      if (node is XmlElement) {
        final name = node.name.local;
        childrenByName[name] ??= [];
        childrenByName[name]!.add(node);
      }
    }

    // Processa os elementos filhos
    for (var entry in childrenByName.entries) {
      final name = entry.key;
      final elements = entry.value;

      if (elements.length == 1) {
        final child = elements.first;

        // Se o elemento tem filhos, processa recursivamente
        if (child.children.whereType<XmlElement>().isNotEmpty) {
          map[name] = _xmlToMap(child);
        } else {
          // Se não tem filhos, pega o texto do elemento
          map[name] = child.innerText;
        }
      } else {
        // Se há múltiplos elementos com o mesmo nome, cria uma lista
        map[name] = elements.map((e) {
          if (e.children.whereType<XmlElement>().isNotEmpty) {
            return _xmlToMap(e);
          } else {
            return e.innerText;
          }
        }).toList();
      }
    }

    return map;
  }

  /// Método público para converter um XML em um objeto `Nfse`.
  ///
  /// Esse método serve como uma interface de alto nível para `_parseNfse`,
  /// encapsulando a lógica de parsing e retornando o objeto resultante.
  ///
  /// ### Parâmetros:
  /// - [xml]: Uma `String` contendo o documento XML que será processado.
  ///
  /// ### Retorno:
  /// - Um objeto `Nfse` se o XML for válido e for uma NFSe Nacional.
  /// - `null` se o XML não for uma NFSe Nacional ou for malformado.
  ///
  /// ### Exemplo:
  /// ```dart
  /// final nfse = NfseParser.readFromString(xmlString);
  /// if (nfse != null) {
  ///   print('NFSe número: ${nfse.infDPS?.nDPS}');
  /// }
  /// ```
  static Nfse? readFromString(String xml) {
    return _parseNfse(xml);
  }

  /// Verifica se um XML é uma NFSe Nacional sem fazer o parse completo.
  ///
  /// ### Parâmetros:
  /// - [xml]: Uma `String` contendo o documento XML.
  ///
  /// ### Retorno:
  /// - `true` se for NFSe Nacional.
  /// - `false` caso contrário.
  ///
  /// ### Exemplo:
  /// ```dart
  /// if (NfseParser.isNfseNacional(xmlString)) {
  ///   print('É uma NFSe Nacional');
  /// }
  /// ```
  static bool isNfseNacional(String xml) {
    try {
      final document = XmlDocument.parse(xml);
      return _isNfseNacional(document);
    } catch (e) {
      return false;
    }
  }

  /// Extrai informações resumidas da NFSe de forma rápida.
  ///
  /// ### Parâmetros:
  /// - [xmlString]: String contendo o XML da NFSe.
  ///
  /// ### Retorno:
  /// - Um `Map<String, String?>` com informações básicas da NFSe.
  ///
  /// ### Exemplo:
  /// ```dart
  /// final info = NfseParser.extractBasicInfo(xmlString);
  /// print('Número: ${info['numero']}');
  /// print('Valor: ${info['valor']}');
  /// ```
  static Map<String, String?> extractBasicInfo(String xmlString) {
    try {
      final document = XmlDocument.parse(xmlString);

      if (!_isNfseNacional(document)) {
        return {};
      }

      // Procura infDPS em qualquer profundidade
      final infDPSElements = document.findAllElements('infDPS');
      if (infDPSElements.isEmpty) {
        return {};
      }

      final infDPS = infDPSElements.first;

      return {
        'numero': _getElementText(infDPS, 'nDPS'),
        'serie': _getElementText(infDPS, 'serie'),
        'dataEmissao': _getElementText(infDPS, 'dhEmi'),
        'dataCompetencia': _getElementText(infDPS, 'dCompet'),
        'cnpjPrestador': _getElementText(infDPS, 'CNPJ'),
        'valorServico': _getElementText(
          infDPS.findAllElements('vServ').isNotEmpty
              ? infDPS.findAllElements('vServ').first.parent as XmlElement
              : infDPS,
          'vServ',
        ),
        'descricaoServico': _getElementText(
          infDPS.findAllElements('xDescServ').isNotEmpty
              ? infDPS.findAllElements('xDescServ').first.parent as XmlElement
              : infDPS,
          'xDescServ',
        ),
      };
    } catch (e) {
      return {};
    }
  }

  /// Obtém o texto de um elemento filho.
  static String? _getElementText(XmlElement parent, String childName) {
    try {
      final elements = parent.findAllElements(childName);
      if (elements.isEmpty) return null;
      return elements.first.innerText;
    } catch (e) {
      return null;
    }
  }
}
