import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as decoder;
import 'package:printer_gateway/printer_gateway.dart';

import 'danfe.dart';

/// Enumeração para definir o tamanho do papel da impressão.
enum DanfePaperSize {
  /// Papel de 58mm (largura de 384 pixels).
  mm58,

  /// Papel de 80mm (largura de 576 pixels).
  mm80,
}

/// Extensão para obter a largura máxima do papel em pixels.
extension DanfePaperSizeExtension on DanfePaperSize {
  /// Retorna a largura máxima do papel em pixels.
  double get maxWidth {
    switch (this) {
      case DanfePaperSize.mm58:
        return 384;
      case DanfePaperSize.mm80:
        return 576;
    }
  }
}

/// Classe responsável por converter dados do DANFE em diferentes formatos de saída
/// utilizando o pacote `printer_gateway`.
///
/// ### Responsabilidades:
/// - Converter JSON do DANFE em Widget Flutter para visualização.
/// - Gerar imagens a partir do JSON do DANFE.
/// - Exportar para formatos compatíveis com impressoras POS e ESC/POS.
///
/// ### Exemplo de uso:
/// ```dart
/// final danfePrinter = DanfePrinter(PaperSize.mm80);
/// final jsonData = danfePrinter.normativeJsonDanfe(danfe);
///
/// final imageDanfe = ImageDanfe(
///   jsonData: jsonData,
///   paperSize: DanfePaperSize.mm80,
/// );
///
/// // Obter Widget para visualização
/// Widget widget = imageDanfe.toWidget();
///
/// // Gerar imagem
/// Uint8List image = await imageDanfe.toImage(context);
/// ```
class ImageDanfe {
  /// JSON string contendo os dados do DANFE no formato do printer_gateway.
  final String jsonData;

  /// Tamanho do papel para impressão.
  final DanfePaperSize paperSize;

  /// Imagem de cabeçalho opcional (logo da empresa, por exemplo).
  Uint8List? _headerImage;

  /// Imagem de rodapé opcional.
  Uint8List? _footerImage;

  /// Instância do PrinterGateway para processamento.
  late PrinterGateway _printerGateway;

  /// Construtor da classe ImageDanfe.
  ///
  /// ### Parâmetros:
  /// - [jsonData]: JSON string com os dados do DANFE (gerado pelo `normativeJsonDanfe`).
  /// - [paperSize]: Tamanho do papel (58mm ou 80mm). Padrão é 80mm.
  /// - [headerImage]: Imagem opcional para o cabeçalho.
  /// - [footerImage]: Imagem opcional para o rodapé.
  ImageDanfe({
    required this.jsonData,
    this.paperSize = DanfePaperSize.mm80,
    Uint8List? headerImage,
    Uint8List? footerImage,
  }) : _headerImage = headerImage,
       _footerImage = footerImage {
    _initPrinterGateway();
  }

  /// Construtor de fábrica para criar ImageDanfe diretamente de um objeto Danfe.
  ///
  /// ### Parâmetros:
  /// - [danfe]: Objeto Danfe contendo os dados do documento fiscal.
  /// - [paperSize]: Tamanho do papel (58mm ou 80mm). Padrão é 80mm.
  /// - [mostrarMoeda]: Define se o símbolo da moeda será exibido. Padrão é true.
  /// - [headerImage]: Imagem opcional para o cabeçalho.
  /// - [footerImage]: Imagem opcional para o rodapé.
  factory ImageDanfe.fromDanfe({
    required Danfe danfe,
    DanfePaperSize paperSize = DanfePaperSize.mm80,
    bool mostrarMoeda = true,
    Uint8List? headerImage,
    Uint8List? footerImage,
  }) {
    final escPosPaperSize = paperSize == DanfePaperSize.mm58 ? PaperSize.mm58 : PaperSize.mm80;
    final danfePrinter = DanfePrinter(escPosPaperSize);
    final jsonData = danfePrinter.normativeJsonDanfe(
      danfe,
      mostrarMoeda: mostrarMoeda,
    );

    return ImageDanfe(
      jsonData: jsonData,
      paperSize: paperSize,
      headerImage: headerImage,
      footerImage: footerImage,
    );
  }

  /// Inicializa o PrinterGateway com os dados do JSON.
  void _initPrinterGateway() {
    _printerGateway = PrinterGateway(
      jsonData: jsonData,
      imageHeader: _headerImage,
      imageFooter: _footerImage,
    );
  }

  /// Adiciona uma imagem de cabeçalho ao DANFE.
  ///
  /// ### Parâmetros:
  /// - [imageBytes]: Bytes da imagem (PNG, JPG, etc.).
  void addHeaderImage(Uint8List imageBytes) {
    _headerImage = imageBytes;
    _printerGateway.addHeaderImage(imageBytes);
  }

  /// Adiciona uma imagem de rodapé ao DANFE.
  ///
  /// ### Parâmetros:
  /// - [imageBytes]: Bytes da imagem (PNG, JPG, etc.).
  void addFooterImage(Uint8List imageBytes) {
    _footerImage = imageBytes;
    _printerGateway.addFooterImage(imageBytes);
  }

  /// Converte o JSON do DANFE em um Widget Flutter para visualização.
  ///
  /// ### Parâmetros:
  /// - [maxWidth]: Largura máxima do widget. Se não fornecido, usa a largura do papel.
  /// - [margin]: Margem horizontal do widget. Padrão é 0.
  ///
  /// ### Retorno:
  /// - Um `Widget` contendo a representação visual do DANFE.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Widget danfeWidget = imageDanfe.toWidget(margin: 16);
  /// ```
  Widget toWidget({
    double? maxWidth,
    int margin = 0,
  }) {
    return _printerGateway.toWidget(
      maxWidth: maxWidth ?? paperSize.maxWidth,
      margin: margin,
    );
  }

  /// Gera uma imagem (Uint8List) a partir do JSON do DANFE.
  ///
  /// ### Parâmetros:
  /// - [context]: BuildContext necessário para renderização.
  /// - [maxWidth]: Largura máxima da imagem. Se não fornecido, usa a largura do papel.
  /// - [margin]: Margem horizontal da imagem. Padrão é 0.
  /// - [fixedRatio]: Proporção fixa para qualidade da imagem. Valores maiores = melhor qualidade.
  ///
  /// ### Retorno:
  /// - Um `Future<Uint8List>` contendo os bytes da imagem gerada.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Uint8List imageBytes = await imageDanfe.toImage(
  ///   context,
  ///   fixedRatio: 2.0,
  /// );
  /// ```
  Future<Uint8List> toImage(
    BuildContext context, {
    double? maxWidth,
    int margin = 0,
    double fixedRatio = 0,
  }) async {
    return await _printerGateway.toImage(
      context,
      maxWidth: maxWidth ?? paperSize.maxWidth,
      margin: margin,
      fixedRatio: fixedRatio,
    );
  }

  /// Converte o DANFE em uma lista de partes de imagem para impressoras POS.
  ///
  /// Automaticamente divide recibos longos em chunks para impressão.
  ///
  /// ### Parâmetros:
  /// - [context]: BuildContext necessário para renderização.
  /// - [maxHeight]: Altura máxima por chunk de imagem. Padrão é 2000.
  /// - [maxWidth]: Largura máxima das imagens. Se não fornecido, usa a largura do papel.
  /// - [margin]: Margem horizontal. Padrão é 0.
  /// - [fixedRatio]: Proporção fixa para qualidade da imagem.
  ///
  /// ### Retorno:
  /// - Um `Future<List<Uint8List>>` contendo as partes da imagem para impressão.
  ///
  /// ### Exemplo:
  /// ```dart
  /// List<Uint8List> imageParts = await imageDanfe.toPosPrinter(context);
  /// for (var part in imageParts) {
  ///   await printer.printImage(part);
  /// }
  /// ```
  Future<List<Uint8List>> toPosPrinter(
    BuildContext context, {
    int maxHeight = 2000,
    double? maxWidth,
    int margin = 0,
    double fixedRatio = 0,
  }) async {
    return await _printerGateway.toPosPrinter(
      context,
      maxHeight: maxHeight,
      maxWidth: maxWidth ?? paperSize.maxWidth,
      margin: margin,
      fixedRatio: fixedRatio,
    );
  }

  /// Converte o DANFE em uma lista de imagens decodificadas para impressoras ESC/POS.
  ///
  /// Retorna objetos Image do pacote `image`, adequados para processamento
  /// com bibliotecas ESC/POS.
  ///
  /// ### Parâmetros:
  /// - [context]: BuildContext necessário para renderização.
  /// - [maxHeight]: Altura máxima por chunk de imagem. Padrão é 2000.
  /// - [maxWidth]: Largura máxima das imagens. Se não fornecido, usa a largura do papel.
  /// - [margin]: Margem horizontal. Padrão é 0.
  /// - [fixedRatio]: Proporção fixa para qualidade da imagem.
  ///
  /// ### Retorno:
  /// - Um `Future<List<decoder.Image>>` contendo as imagens decodificadas.
  ///
  /// ### Exemplo:
  /// ```dart
  /// List<decoder.Image> rasterImages = await imageDanfe.toEscPosPrinter(context);
  /// for (var image in rasterImages) {
  ///   await escPosPrinter.printRaster(image);
  /// }
  /// ```
  Future<List<decoder.Image>> toEscPosPrinter(
    BuildContext context, {
    int maxHeight = 2000,
    double? maxWidth,
    int margin = 0,
    double fixedRatio = 0,
  }) async {
    return await _printerGateway.toEscPosPrinter(
      context,
      maxHeight: maxHeight,
      maxWidth: maxWidth ?? paperSize.maxWidth,
      margin: margin,
      fixedRatio: fixedRatio,
    );
  }

  /// Atualiza os dados do JSON do DANFE.
  ///
  /// Útil para atualizar o conteúdo sem criar uma nova instância.
  ///
  /// ### Parâmetros:
  /// - [newJsonData]: Novo JSON string com os dados do DANFE.
  void updateData(String newJsonData) {
    _printerGateway.addData(newJsonData);
  }
}
