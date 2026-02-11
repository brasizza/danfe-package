import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import '../../danfe.dart';

/// Classe auxiliar para criação de estruturas JSON para impressão.
///
/// Centraliza métodos comuns utilizados por DanfePrinter e NfsePrinter
/// para gerar JSON normativo compatível com printer_gateway.
class JsonPrinterHelper {
  /// Nome da fonte a ser utilizada na impressão.
  String? fontName;

  /// Construtor da classe JsonPrinterHelper.
  ///
  /// [fontName] - Nome da fonte customizada. Valor padrão é 'RobotoMonoRegular'.
  JsonPrinterHelper({this.fontName = 'RobotoMonoRegular'});

  /// Cria uma linha customizada com estilização.
  ///
  /// [bold] - Define se o texto será negrito. Padrão: false.
  /// [italic] - Define se o texto será itálico. Padrão: false.
  /// [aligment] - Define o alinhamento (0: esquerda, 1: centro, 2: direita). Padrão: 1.
  /// [fontSize] - Define o tamanho da fonte. Padrão: 12.
  /// [content] - Conteúdo da linha.
  ///
  /// Retorna um Map representando a linha customizada.
  Map prepareLine({
    bool bold = false,
    bool italic = false,
    int aligment = 1,
    int fontSize = 12,
    String content = '',
  }) {
    Map customLine = {};
    customLine['line'] = {};
    customLine['line']['customization'] = {};
    customLine['line']['customization']['font_style'] = {};
    customLine['line']['customization']['font_style']['bold'] = bold;
    customLine['line']['customization']['font_size'] = fontSize;
    customLine['line']['customization']['font_name'] = fontName;
    customLine['line']['customization']['alignment'] = aligment;
    customLine['line']['customization']['font_style']['italic'] = italic;
    customLine['line']['content'] = content;
    return customLine;
  }

  /// Cria um divisor horizontal.
  ///
  /// Retorna um Map representando um divisor.
  Map divider() {
    Map divider = {};
    divider['line'] = {};
    divider['line']['divider'] = true;
    return divider;
  }

  /// Cria um salto de linhas.
  ///
  /// [lines] - Número de linhas a pular.
  ///
  /// Retorna um Map representando o salto de linhas.
  Map prepareJump(int lines) {
    Map jump = {};
    jump['line'] = {};
    jump['line']['jump'] = lines;
    return jump;
  }

  /// Cria um QR Code.
  ///
  /// [size] - Tamanho do QR Code. Padrão: 100.
  /// [content] - Conteúdo do QR Code.
  /// [level] - Nível de correção de erro ('L', 'M', 'Q', 'H'). Padrão: 'H'.
  ///
  /// Retorna um Map representando o QR Code.
  Map prepareQrcode({
    int size = 100,
    String content = '',
    String level = 'H',
  }) {
    Map qrcode = {};
    qrcode['line'] = {};
    qrcode['line']['qrcode'] = {};
    qrcode['line']['qrcode']['size'] = size;
    qrcode['line']['qrcode']['content'] = content;
    qrcode['line']['qrcode']['level'] = level;
    return qrcode;
  }

  /// Cria uma linha (row) para uso em colunas.
  ///
  /// [row] - Map contendo as propriedades da linha (text, alignment, bold, italic, size).
  /// [paperSize] - Tamanho do papel para ajuste do tamanho da fonte.
  ///
  /// Retorna um Map representando uma linha.
  Map createRow({required Map row, required PaperSize paperSize}) {
    final lineRow = {};
    lineRow['row'] = {};
    lineRow['row']['customization'] = {};
    lineRow['row']['customization']['font_size'] = paperSize == PaperSize.mm58
        ? 10
        : 12;
    lineRow['row']['customization']['alignment'] = row.containsKey('alignment')
        ? row['alignment']
        : 0;
    lineRow['row']['customization']['font_style'] = {};
    lineRow['row']['customization']['font_style']['bold'] =
        row.containsKey('bold') ? row['bold'] : false;
    lineRow['row']['customization']['font_style']['italic'] =
        row.containsKey('italic') ? row['italic'] : false;

    lineRow['row']['customization']['font_name'] = fontName;
    lineRow['row']['content'] = row['text'];
    lineRow['row']['size'] = row['size'];
    return lineRow;
  }

  /// Cria um cabeçalho para tabela.
  ///
  /// [headers] - Lista de Maps representando cada coluna do cabeçalho.
  /// [paperSize] - Tamanho do papel.
  ///
  /// Retorna uma lista de Maps representando o cabeçalho.
  List<Map> createHeader({
    required List<Map> headers,
    required PaperSize paperSize,
  }) {
    List<Map> header = [];
    for (var row in headers) {
      header.add(createRow(row: row, paperSize: paperSize));
    }

    return header;
  }

  /// Cria uma coluna com múltiplas linhas.
  ///
  /// [rows] - Lista de Maps representando as linhas da coluna.
  /// [paperSize] - Tamanho do papel.
  ///
  /// Retorna um Map representando a coluna.
  Map createColumn({required List<Map> rows, required PaperSize paperSize}) {
    Map column = {};
    column['line'] = {};
    column['line']['column'] = rows.toList();

    return column;
  }

  /// Cria uma estrutura de coluna com itens (produtos).
  ///
  /// [paperSize] - Tamanho do papel.
  /// [det] - Lista de itens (Det) do DANFE.
  ///
  /// Retorna um Map representando a coluna com itens.
  Map createColumnItems({required PaperSize paperSize, List<Det>? det}) {
    List<Map> headers = [];
    if (paperSize == PaperSize.mm58) {
      headers.add({'text': "DESCRICAO", 'size': 65, 'bold': true});
      headers.add({'text': "QTD", 'size': 15, 'bold': true, 'alignment': 2});
      headers.add({'text': "VLTOT", 'size': 20, 'bold': true, 'alignment': 2});
    } else {
      headers.add({'text': "DESCRICAO", 'size': 50, 'bold': true});
      headers.add({'text': "QTD", 'size': 10, 'bold': true, 'alignment': 2});
      headers.add({'text': "VLUN", 'size': 20, 'bold': true, 'alignment': 2});
      headers.add({'text': "VLTOT", 'size': 20, 'bold': true, 'alignment': 2});
    }

    Map column = {};
    column['line'] = {};
    column['line']['column'] = [];
    column['line']['column'].add({
      'header': createHeader(headers: headers, paperSize: paperSize),
      'items': createItems(det: det, paperSize: paperSize),
    });

    return column;
  }

  /// Cria a lista de itens para a tabela de produtos.
  ///
  /// [det] - Lista de itens (Det) do DANFE.
  /// [paperSize] - Tamanho do papel.
  ///
  /// Retorna uma lista de itens formatados.
  List<dynamic> createItems({List<Det>? det, required PaperSize paperSize}) {
    List items = [];
    if (det != null) {
      for (Det item in det) {
        final detList = <Map>[];

        if (paperSize == PaperSize.mm58) {
          detList.add(
            createRow(
              row: {'text': item.prod?.xProd ?? ''},
              paperSize: paperSize,
            ),
          );
          detList.add(
            createRow(
              row: {
                'text': DanfeUtils.formatNumber(item.prod?.qCom ?? ''),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          );
          detList.add(
            createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  item.prod?.vProd ?? '',
                  modeda: 'pt_BR',
                  simbolo: '',
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          );
        } else {
          detList.add(
            createRow(
              row: {'text': item.prod?.xProd ?? ''},
              paperSize: paperSize,
            ),
          );
          detList.add(
            createRow(
              row: {
                'text': DanfeUtils.formatNumber(item.prod?.qCom ?? ''),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          );

          detList.add(
            createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  item.prod?.vUnCom ?? '',
                  modeda: 'pt_BR',
                  simbolo: '',
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          );
          detList.add(
            createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  item.prod?.vProd ?? '',
                  modeda: 'pt_BR',
                  simbolo: '',
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          );
        }

        items.add(detList);
      }
    }
    return items;
  }
}
