import '../../danfe.dart';

/// A interface `IDanfePrinter` define os contratos necessários para a implementação de
/// classes que gerenciam a impressão e manipulação de documentos DANFE (Documento Auxiliar da Nota Fiscal Eletrônica).
///
/// ### Responsabilidades:
/// - Geração de buffers em formato ESC/POS para impressão em impressoras térmicas.
/// - Geração de representações normativas em JSON do DANFE.
///
/// Qualquer classe que implemente essa interface deve fornecer implementações concretas para os métodos definidos.
abstract class IDanfePrinter {
  /// Gera um buffer de comandos ESC/POS para impressão do DANFE em uma impressora térmica.
  ///
  /// ### Parâmetros:
  /// - [danfe]: Objeto `Danfe` contendo os dados do documento fiscal.
  /// - [mostrarMoeda] (opcional): Um `bool` que define se o símbolo da moeda será exibido.
  ///   O valor padrão é `true`.
  ///
  /// ### Retorno:
  /// - Um `Future` contendo uma lista de bytes (`List<int>`) representando os comandos ESC/POS
  ///   que podem ser enviados para a impressora térmica.
  Future<List<int>> bufferDanfe(Danfe? danfe, {bool mostrarMoeda = true});

  /// Gera uma representação normativa em formato JSON do DANFE.
  ///
  /// ### Parâmetros:
  /// - [danfe]: Objeto `Danfe` contendo os dados do documento fiscal.
  /// - [mostrarMoeda] (opcional): Um `bool` que define se o símbolo da moeda será exibido.
  ///   O valor padrão é `true`.
  ///
  /// ### Retorno:
  /// - Uma `String` contendo o JSON gerado a partir dos dados do DANFE.
  String normativeJsonDanfe(Danfe? danfe, {bool mostrarMoeda = true});
}
