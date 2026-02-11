import 'dart:convert';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'danfe.dart';

class DanfePrinter implements IDanfePrinter {
  /// Define o tamanho do papel utilizado para a impressão (58mm ou 80mm).
  final PaperSize paperSize;

  /// Construtor da classe DanfePrinter.
  ///
  /// Recebe o tamanho do papel como parâmetro para configuração da impressão.
  DanfePrinter(this.paperSize);

  /// Gera o buffer de dados para impressão do DANFE em formato ESC/POS.
  ///
  /// [danfe] - Dados do DANFE que serão processados para impressão.
  /// [mostrarMoeda] - Define se o símbolo da moeda deve ser exibido. Valor padrão é `true`.
  ///
  /// Retorna uma lista de bytes que representa os comandos de impressão.
  String? fontName = 'RobotoMonoRegular';
  @override
  Future<List<int>> bufferDanfe(
    Danfe? danfe, {
    bool mostrarMoeda = true,
  }) async {
    String moeda = (mostrarMoeda == true) ? r'R$' : '';
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];
    // Print image
    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.text(
      DanfeUtils.removeAcentos(
        danfe?.dados?.emit?.xFant ?? (danfe?.dados?.emit?.xNome ?? ''),
      ),
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    final String uf = danfe?.dados?.emit?.enderEmit?.uF == null
        ? ''
        : ' - ${danfe!.dados!.emit!.enderEmit!.uF}';
    bytes += generator.text(
      ('CNPJ - ${DanfeUtils.formatCNPJ(danfe?.dados?.emit?.cnpj ?? '')}'),
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      DanfeUtils.removeAcentos(
        '${danfe?.dados?.emit?.enderEmit?.xLgr ?? ''},${danfe?.dados?.emit?.enderEmit?.nro ?? ''} ${danfe?.dados?.emit?.enderEmit?.xBairro ?? ''}$uf',
      ),
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      'CEP: ${DanfeUtils.formatCep(danfe?.dados?.emit?.enderEmit?.cEP ?? '')}',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.rawBytes([27, 97, 48]);
    bytes += generator.hr();
    bytes += generator.rawBytes([27, 97, 49]);
    if ((danfe?.tipo ?? TipoDocumento.CFe) == TipoDocumento.CFe) {
      bytes += generator.text(
        'Nota Fiscal Eletronica - SAT ',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      );
    } else if ((danfe?.tipo ?? TipoDocumento.NFCe) == TipoDocumento.NFCe) {
      bytes += generator.text(
        'Nota Fiscal Eletronica - NFC-E ',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      );
    } else {
      bytes += generator.text(
        'Nota Fiscal Eletronica - NFe ',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      );
    }
    bytes += generator.rawBytes([27, 97, 48]);
    var documentoConsumidor = (danfe?.dados?.dest?.cpf != null)
        ? DanfeUtils.formatCPF(danfe?.dados?.dest?.cpf ?? '')
        : DanfeUtils.formatCNPJ(danfe?.dados?.dest?.cnpj ?? '');
    bytes += generator.text(
      "CPF/CNPJ do consumidor: $documentoConsumidor",
      styles: const PosStyles(align: PosAlign.left),
    );
    if (danfe?.dados?.dest?.xNome != '' || danfe?.dados?.dest?.xNome != null) {
      bytes += generator.text(
        "Nome: ${danfe?.dados?.dest?.xNome ?? ''}",
        styles: const PosStyles(align: PosAlign.left),
      );
    }
    bytes += generator.text(
      "Nota: ${danfe?.dados?.ide?.nNF ?? ''}",
      styles: const PosStyles(align: PosAlign.left),
    );
    bytes += generator.text(
      'Data: ${DanfeUtils.formatDate(danfe?.dados?.ide?.dataEmissao ?? '')}',
      styles: const PosStyles(align: PosAlign.center),
    );
    if (danfe?.dados?.ide?.dhSaiEnt != null) {
      bytes += generator.text(
        'Data E/S: ${DanfeUtils.formatDate(danfe?.dados?.ide?.dhSaiEnt ?? '')}',
        styles: const PosStyles(align: PosAlign.center),
      );
    }

    bytes += generator.hr();

    if (paperSize == PaperSize.mm58) {
      bytes += generator.row([
        PosColumn(
          text: 'DESCRICAO',
          width: 7,
          styles: const PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: 'QTD',
          width: 2,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
        PosColumn(
          text: 'VLTOT',
          width: 3,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]);
    } else {
      bytes += generator.row([
        PosColumn(
          text: 'DESCRICAO',
          width: 5,
          styles: const PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: 'QTD',
          width: 1,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
        PosColumn(
          text: 'VLUN',
          width: 3,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
        PosColumn(
          text: 'VLTOT',
          width: 3,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]);
    }
    if (danfe?.dados?.det != null) {
      for (Det det in danfe!.dados!.det!) {
        if (paperSize == PaperSize.mm58) {
          bytes += generator.row([
            PosColumn(
              text: det.prod?.xProd ?? '',
              width: 7,
              styles: const PosStyles(
                align: PosAlign.left,
                width: PosTextSize.size1,
              ),
            ),
            PosColumn(
              text: DanfeUtils.formatNumber(det.prod?.qCom ?? ''),
              width: 2,
              styles: const PosStyles(align: PosAlign.right),
            ),
            PosColumn(
              text: DanfeUtils.formatMoneyMilhar(
                det.prod?.vProd ?? '',
                modeda: 'pt_BR',
                simbolo: moeda,
              ),
              width: 3,
              styles: const PosStyles(align: PosAlign.right),
            ),
          ]);
        } else {
          bytes += generator.row([
            PosColumn(
              text: det.prod?.xProd ?? '',
              width: 5,
              styles: const PosStyles(align: PosAlign.left),
            ),
            PosColumn(
              text: DanfeUtils.formatNumber(det.prod?.qCom ?? ''),
              width: 1,
              styles: const PosStyles(align: PosAlign.right),
            ),
            PosColumn(
              text: DanfeUtils.formatMoneyMilhar(
                det.prod?.vUnCom ?? '',
                modeda: 'pt_BR',
                simbolo: moeda,
              ),
              width: 3,
              styles: const PosStyles(align: PosAlign.right),
            ),
            PosColumn(
              text: DanfeUtils.formatMoneyMilhar(
                det.prod?.vProd ?? '',
                modeda: 'pt_BR',
                simbolo: moeda,
              ),
              width: 3,
              styles: const PosStyles(align: PosAlign.right),
            ),
          ]);
        }
      }
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'QTD DE ITENS',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: DanfeUtils.formatNumber(
          danfe?.dados?.det?.length.toString() ?? '',
        ),
        width: 6,
        styles: const PosStyles(
          align: PosAlign.right,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'SUBTOTAL',
        width: 6,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
      PosColumn(
        text: DanfeUtils.formatMoneyMilhar(
          danfe?.dados?.total?.valorTotal ?? '',
          modeda: 'pt_BR',
          simbolo: moeda,
        ),
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);

    if ((danfe?.dados?.total?.valorFrete ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(
          text: 'FRETE',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
            danfe?.dados?.total?.valorFrete ?? '',
            modeda: 'pt_BR',
            simbolo: moeda,
          ),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    if ((danfe?.dados?.total?.desconto ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(
          text: 'DESCONTO',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
            danfe?.dados?.total?.desconto ?? '',
            modeda: 'pt_BR',
            simbolo: moeda,
          ),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    if ((danfe?.dados?.total?.acrescimo ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(text: 'ACRESCIMO', width: 6, styles: const PosStyles()),
        PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
            danfe?.dados?.total?.acrescimo ?? '',
            modeda: 'pt_BR',
            simbolo: moeda,
          ),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    if ((danfe?.dados?.pgto?.vTroco ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(
          text: 'TROCO',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
            danfe?.dados?.pgto?.vTroco ?? '',
            modeda: 'pt_BR',
            simbolo: moeda,
          ),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.row([
      PosColumn(
        text: 'TOTAL',
        width: 6,
        styles: const PosStyles(bold: true, align: PosAlign.left),
      ),
      PosColumn(
        text: DanfeUtils.formatMoneyMilhar(
          danfe?.dados?.total?.valorPago ?? '0.00',
          modeda: 'pt_BR',
          simbolo: moeda,
        ),
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);
    bytes += generator.hr();
    if (danfe?.dados?.pgto != null) {
      bytes += generator.row([
        PosColumn(
          text: 'FORMAS DE PAGAMENTO',
          width: 6,
          styles: const PosStyles(bold: true),
        ),
        PosColumn(
          text: 'VALOR PAGO',
          width: 6,
          styles: const PosStyles(align: PosAlign.right, bold: true),
        ),
      ]);
      for (MP pagamento in danfe!.dados!.pgto!.formas!) {
        bytes += generator.row([
          PosColumn(
            text: DanfeUtils.removeAcentos(pagamento.cMP ?? ''),
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              pagamento.vMP ?? '',
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }
      bytes += generator.hr();
    }

    if (danfe?.dados?.total?.valotTotalTributos != null) {
      if (danfe!.dados!.total!.valotTotalTributos != '0.00') {
        bytes += generator.row([
          PosColumn(
            text: 'Tributos totais incidentes:',
            width: 9,
            styles: const PosStyles(bold: false),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              danfe.dados!.total!.valotTotalTributos ?? '',
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 3,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
        bytes += generator.feed(1);
      }
    }

    if (danfe?.dados?.transp != null) {
      if (danfe?.dados?.transp?.transporta?.xNome != null) {
        bytes += generator.rawBytes([27, 97, 49]);
        bytes += generator.text(
          'TRANSPORTADORA',
          styles: const PosStyles(align: PosAlign.center, bold: true),
        );

        bytes += generator.text(
          DanfeUtils.removeAcentos(
            (danfe?.dados?.transp?.transporta?.xNome ?? ''),
          ),
        );
        bytes += generator.text(
          DanfeUtils.removeAcentos(
            (danfe?.dados?.transp?.transporta?.xEnder ?? ''),
          ),
        );
        bytes += generator.text(
          DanfeUtils.removeAcentos(
            '${danfe?.dados?.transp?.transporta?.xMun ?? ''} ${danfe?.dados?.transp?.transporta?.uf ?? ''}',
          ),
        );
        bytes += generator.rawBytes([27, 97, 48]);

        bytes += generator.hr();
      }
    }

    if (danfe?.dados?.cobr != null) {
      bytes += generator.rawBytes([27, 97, 49]);
      bytes += generator.text(
        'COBRANCA',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );

      bytes += generator.text("Fatura: ${danfe?.dados?.cobr?.fat?.nFat ?? ''}");
      bytes += generator.text(
        "Valor Original: ${DanfeUtils.formatMoneyMilhar(danfe?.dados?.cobr?.fat?.vOrig ?? '', modeda: 'pt_BR', simbolo: moeda)}",
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.text(
        "Valor Liquido: ${DanfeUtils.formatMoneyMilhar(danfe?.dados?.cobr?.fat?.vLiq ?? '', modeda: 'pt_BR', simbolo: moeda)}",
        styles: const PosStyles(align: PosAlign.center),
      );
      bytes += generator.hr();
      for (var duplicata in danfe?.dados?.cobr?.dup ?? []) {
        bytes += generator.text("Duplicata: ${duplicata.nDup ?? ''}");
        bytes += generator.text(
          "Vencimento: ${DanfeUtils.formatDate(duplicata.dVenc ?? '', dateOnly: true)}",
        );
        bytes += generator.text("Valor: ${duplicata.nDup ?? ''}");

        bytes += generator.hr();
      }
      bytes += generator.rawBytes([27, 97, 48]);
    }

    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.text(
      'CHAVE DE ACESSO DA NOTA FISCAL',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.text(
      DanfeUtils.splitByLength(danfe?.dados?.chaveNota ?? '', 4, ' '),
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    if ((danfe?.tipo ?? TipoDocumento.NFCe) != TipoDocumento.NFe) {
      bytes += generator.rawBytes([27, 97, 49]);
      bytes += generator.qrcode(
        danfe?.qrcodePrinter ?? '',
        size: QRSize.size4,
        cor: QRCorrection.M,
      );

      bytes += generator.rawBytes([27, 97, 48]);
    }
    bytes += generator.feed(1);

    if (danfe?.dados?.ide?.serie != null) {
      final serie = (danfe?.dados?.ide?.serie ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');
      bytes += generator.rawBytes([27, 97, 49]);

      bytes += generator.text(
        'Nota $nnf Serie $serie ',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]);

      bytes += generator.feed(1);
    }

    if (danfe?.dados?.ide?.nserieSAT != null) {
      final serie = (danfe?.dados?.ide?.nserieSAT ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');
      bytes += generator.rawBytes([27, 97, 49]);
      bytes += generator.text(
        'Nota $nnf Serie $serie',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]);

      bytes += generator.feed(1);
    }

    if (danfe?.protNFe != null) {
      bytes += generator.row([
        PosColumn(
          text: 'Protocolo: ',
          width: 6,
          styles: const PosStyles(bold: true),
        ),
        PosColumn(
          text: danfe?.protNFe?.infProt?.nProt ?? '',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      DateTime dateTime = DateTime.parse(
        danfe?.protNFe?.infProt?.dhRecbto ?? DateTime.now().toIso8601String(),
      );
      String formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

      bytes += generator.row([
        PosColumn(
          text: 'Data: ',
          width: 6,
          styles: const PosStyles(bold: true),
        ),
        PosColumn(
          text: formattedDate,
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.feed(1);
    }

    if (danfe?.dados?.infAdic?.infCpl != null) {
      bytes += generator.text(
        danfe!.dados!.infAdic!.infCpl ?? ' ',
        styles: const PosStyles(align: PosAlign.center),
      );
    }

    bytes += generator.cut();
    bytes += generator.reset();

    return bytes;
  }

  @override
  String normativeJsonDanfe(
    Danfe? danfe, {
    bool mostrarMoeda = true,
    String customFont = 'RobotoMonoRegular',
  }) {
    String moeda = (mostrarMoeda == true) ? 'R\$' : '';
    fontName = customFont;
    final helper = JsonPrinterHelper(fontName: customFont);

    List<Map> danfeJson = [];

    danfeJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: true,
        fontSize: 18,
        italic: false,
        content: danfe?.dados?.emit?.xFant ?? (danfe?.dados?.emit?.xNome ?? ''),
      ),
    );
    danfeJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: false,
        fontSize: 14,
        italic: false,
        content:
            'CNPJ - ${DanfeUtils.formatCNPJ(danfe?.dados?.emit?.cnpj ?? '')}',
      ),
    );
    final String uf = danfe?.dados?.emit?.enderEmit?.uF == null
        ? ''
        : ' - ${danfe!.dados!.emit!.enderEmit!.uF}';
    danfeJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: false,
        fontSize: 14,
        italic: false,
        content: DanfeUtils.removeAcentos(
          '${danfe?.dados?.emit?.enderEmit?.xLgr ?? ''},${danfe?.dados?.emit?.enderEmit?.nro ?? ''} ${danfe?.dados?.emit?.enderEmit?.xBairro ?? ''}$uf',
        ),
      ),
    );
    danfeJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: false,
        fontSize: 14,
        italic: false,
        content:
            'CEP: ${DanfeUtils.formatCep(danfe?.dados?.emit?.enderEmit?.cEP ?? '')}',
      ),
    );
    danfeJson.add(helper.divider());
    if ((danfe?.tipo ?? TipoDocumento.CFe) == TipoDocumento.CFe) {
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: true,
          fontSize: 14,
          italic: false,
          content: ('Nota Fiscal Eletronica - SAT '),
        ),
      );
    } else if ((danfe?.tipo ?? TipoDocumento.NFCe) == TipoDocumento.NFCe) {
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: true,
          fontSize: 14,
          italic: false,
          content: ('Nota Fiscal Eletronica - NFC-E '),
        ),
      );
    } else {
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: true,
          fontSize: 14,
          italic: false,
          content: ('Nota Fiscal Eletronica - NFe '),
        ),
      );
    }
    danfeJson.add(
      helper.prepareLine(
        aligment: 0,
        bold: false,
        fontSize: 14,
        italic: false,
        content:
            "CPF/CNPJ do consumidor: ${danfe?.dados?.dest?.cpf ?? danfe?.dados?.dest?.cnpj ?? ''}",
      ),
    );
    if (danfe?.dados?.dest?.xNome != '' && danfe?.dados?.dest?.xNome != null) {
      danfeJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 14,
          italic: false,
          content: "Nome: ${danfe?.dados?.dest?.xNome ?? ''}",
        ),
      );
    }
    danfeJson.add(
      helper.prepareLine(
        aligment: 0,
        bold: false,
        fontSize: 14,
        italic: false,
        content: ("Nota: ${danfe?.dados?.ide?.nNF ?? ''}"),
      ),
    );
    danfeJson.add(
      helper.prepareLine(
        aligment: 0,
        bold: false,
        fontSize: 14,
        italic: false,
        content:
            ('Data: ${DanfeUtils.formatDate(danfe?.dados?.ide?.dataEmissao ?? '')}'),
      ),
    );
    if (danfe?.dados?.ide?.dhSaiEnt != null) {
      danfeJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 14,
          italic: false,
          content:
              ('Data E/S: ${DanfeUtils.formatDate(danfe?.dados?.ide?.dhSaiEnt ?? '')}'),
        ),
      );
    }
    danfeJson.add(helper.divider());

    danfeJson.add(
      helper.createColumnItems(paperSize: paperSize, det: danfe?.dados?.det),
    );

    danfeJson.add(helper.divider());

    danfeJson.add(
      helper.createColumn(
        paperSize: paperSize,
        rows: [
          helper.createRow(
            row: {'text': 'QTD de itens', 'alignment': 0},
            paperSize: paperSize,
          ),
          helper.createRow(
            row: {
              'text': DanfeUtils.formatNumber(
                danfe?.dados?.det?.length.toString() ?? '',
              ),
              'alignment': 2,
            },
            paperSize: paperSize,
          ),
        ],
      ),
    );

    danfeJson.add(
      helper.createColumn(
        paperSize: paperSize,
        rows: [
          helper.createRow(
            row: {'text': 'SUBTOTAL', 'alignment': 0, 'bold': true},
            paperSize: paperSize,
          ),
          helper.createRow(
            row: {
              'text': DanfeUtils.formatMoneyMilhar(
                danfe?.dados?.total?.valorTotal ?? '',
                modeda: 'pt_BR',
                simbolo: moeda,
              ),
              'alignment': 2,
              'bold': true,
            },
            paperSize: paperSize,
          ),
        ],
      ),
    );

    if ((danfe?.dados?.total?.valorFrete ?? '0.00') != '0.00') {
      danfeJson.add(
        helper.createColumn(
          paperSize: paperSize,
          rows: [
            helper.createRow(
              row: {'text': 'FRETE', 'alignment': 0},
              paperSize: paperSize,
            ),
            helper.createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  danfe?.dados?.total?.valorFrete ?? '',
                  modeda: 'pt_BR',
                  simbolo: moeda,
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          ],
        ),
      );
    }

    if ((danfe?.dados?.total?.desconto ?? '0.00') != '0.00') {
      danfeJson.add(
        helper.createColumn(
          paperSize: paperSize,
          rows: [
            helper.createRow(
              row: {'text': 'Desconto', 'alignment': 0},
              paperSize: paperSize,
            ),
            helper.createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  danfe?.dados?.total?.desconto ?? '',
                  modeda: 'pt_BR',
                  simbolo: moeda,
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          ],
        ),
      );
    }

    if ((danfe?.dados?.total?.acrescimo ?? '0.00') != '0.00') {
      danfeJson.add(
        helper.createColumn(
          paperSize: paperSize,
          rows: [
            helper.createRow(
              row: {'text': 'Acréscimo', 'alignment': 0},
              paperSize: paperSize,
            ),
            helper.createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  danfe?.dados?.total?.acrescimo ?? '',
                  modeda: 'pt_BR',
                  simbolo: moeda,
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          ],
        ),
      );
    }
    if ((danfe?.dados?.pgto?.vTroco ?? '0.00') != '0.00') {
      danfeJson.add(
        helper.createColumn(
          paperSize: paperSize,
          rows: [
            helper.createRow(
              row: {'text': 'Troco', 'alignment': 0},
              paperSize: paperSize,
            ),
            helper.createRow(
              row: {
                'text': DanfeUtils.formatMoneyMilhar(
                  danfe?.dados?.pgto?.vTroco ?? '',
                  modeda: 'pt_BR',
                  simbolo: moeda,
                ),
                'alignment': 2,
              },
              paperSize: paperSize,
            ),
          ],
        ),
      );
    }

    danfeJson.add(
      helper.createColumn(
        paperSize: paperSize,
        rows: [
          helper.createRow(
            row: {'text': 'Total', 'alignment': 0, 'bold': true},
            paperSize: paperSize,
          ),
          helper.createRow(
            row: {
              'text': DanfeUtils.formatMoneyMilhar(
                danfe?.dados?.total?.valorPago ?? '0.00',
                modeda: 'pt_BR',
                simbolo: moeda,
              ),
              'alignment': 2,
              'bold': true,
            },
            paperSize: paperSize,
          ),
        ],
      ),
    );

    danfeJson.add(helper.divider());

    if (danfe?.dados?.pgto != null) {
      danfeJson.add(
        helper.createColumn(
          paperSize: paperSize,
          rows: [
            helper.createRow(
              row: {
                'text': 'Formas de pagamento',
                'alignment': 0,
                'bold': true,
              },
              paperSize: paperSize,
            ),
            helper.createRow(
              row: {'text': 'Valor pago', 'alignment': 2, 'bold': true},
              paperSize: paperSize,
            ),
          ],
        ),
      );

      for (MP pagamento in danfe!.dados!.pgto!.formas!) {
        danfeJson.add(
          helper.createColumn(
            paperSize: paperSize,
            rows: [
              helper.createRow(
                row: {
                  'text': DanfeUtils.removeAcentos(pagamento.cMP ?? ''),
                  'alignment': 0,
                },
                paperSize: paperSize,
              ),
              helper.createRow(
                row: {
                  'text': DanfeUtils.formatMoneyMilhar(
                    pagamento.vMP ?? '',
                    modeda: 'pt_BR',
                    simbolo: moeda,
                  ),
                  'alignment': 2,
                },
                paperSize: paperSize,
              ),
            ],
          ),
        );
      }
      danfeJson.add(helper.divider());
    }

    if (danfe?.dados?.total?.valotTotalTributos != null) {
      if (danfe!.dados!.total!.valotTotalTributos != '0.00') {
        danfeJson.add(
          helper.createColumn(
            paperSize: paperSize,
            rows: [
              helper.createRow(
                row: {'text': 'Tributos totais incidentes:', 'alignment': 0},
                paperSize: paperSize,
              ),
              helper.createRow(
                row: {
                  'text': DanfeUtils.formatMoneyMilhar(
                    danfe.dados!.total!.valotTotalTributos ?? '',
                    modeda: 'pt_BR',
                    simbolo: moeda,
                  ),
                  'alignment': 2,
                },
                paperSize: paperSize,
              ),
            ],
          ),
        );
        danfeJson.add(helper.prepareJump(1));
      }
    }

    if (danfe?.dados?.transp != null) {
      if (danfe?.dados?.transp?.transporta?.xNome != null) {
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            bold: true,
            content: 'TRANSPORTADORA',
          ),
        );
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content: DanfeUtils.removeAcentos(
              danfe?.dados?.transp?.transporta?.xNome ?? '',
            ),
          ),
        );
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content: DanfeUtils.removeAcentos(
              danfe?.dados?.transp?.transporta?.xEnder ?? '',
            ),
          ),
        );
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content: DanfeUtils.removeAcentos(
              '${danfe?.dados?.transp?.transporta?.xMun ?? ''} ${danfe?.dados?.transp?.transporta?.uf ?? ''}',
            ),
          ),
        );
        danfeJson.add(helper.divider());
      }
    }

    if (danfe?.dados?.cobr != null) {
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: true,
          content: 'COBRANCA',
        ),
      );
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          content: "Fatura: ${danfe?.dados?.cobr?.fat?.nFat ?? ''}",
        ),
      );
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          content:
              "Valor Original: ${DanfeUtils.formatMoneyMilhar(danfe?.dados?.cobr?.fat?.vOrig ?? '', modeda: 'pt_BR', simbolo: moeda)}",
        ),
      );
      danfeJson.add(
        helper.prepareLine(
          aligment: 1,
          content:
              "Valor Liquido: ${DanfeUtils.formatMoneyMilhar(danfe?.dados?.cobr?.fat?.vLiq ?? '', modeda: 'pt_BR', simbolo: moeda)}",
        ),
      );
      danfeJson.add(helper.divider());
      for (var duplicata in danfe?.dados?.cobr?.dup ?? []) {
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content: "Duplicata: ${duplicata.nDup ?? ''}",
          ),
        );
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content:
                "Vencimento: ${DanfeUtils.formatDate(duplicata.dVenc ?? '', dateOnly: true)}",
          ),
        );
        danfeJson.add(
          helper.prepareLine(
            aligment: 1,
            content:
                "Valor: ${DanfeUtils.formatMoneyMilhar(duplicata.vDup ?? '', modeda: 'pt_BR', simbolo: moeda)}",
          ),
        );
        danfeJson.add(helper.divider());
      }
    }

    danfeJson.add(
      helper.prepareLine(content: 'CHAVE DE ACESSO DA NOTA FISCAL'),
    );
    danfeJson.add(
      helper.prepareLine(
        fontSize: 14,
        bold: true,
        content: DanfeUtils.splitByLength(
          danfe?.dados?.chaveNota ?? '',
          4,
          ' ',
        ),
      ),
    );
    danfeJson.add(
      helper.prepareQrcode(
        content: danfe?.qrcodePrinter ?? '',
        size: 160,
        level: 'L',
      ),
    );

    if (danfe?.dados?.ide?.serie != null) {
      final serie = (danfe?.dados?.ide?.serie ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');
      danfeJson.add(helper.prepareLine(content: 'Nota $nnf Serie $serie '));
    }

    if (danfe?.dados?.ide?.nserieSAT != null) {
      final serie = (danfe?.dados?.ide?.nserieSAT ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');

      danfeJson.add(helper.prepareLine(content: 'Nota $nnf Serie $serie '));
    }

    if (danfe?.protNFe != null) {
      danfeJson.add(
        helper.prepareLine(
          content: 'Protocolo: ${danfe?.protNFe?.infProt?.nProt ?? ''} ',
        ),
      );

      DateTime dateTime = DateTime.parse(
        danfe?.protNFe?.infProt?.dhRecbto ?? DateTime.now().toIso8601String(),
      );
      String formattedDate =
          "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
      danfeJson.add(helper.prepareLine(content: 'Data: $formattedDate '));
    }

    if (danfe?.dados?.infAdic?.infCpl != null) {
      danfeJson.add(
        helper.prepareLine(
          content: danfe!.dados!.infAdic!.infCpl ?? '',
          fontSize: 14,
        ),
      );
    }
    return json.encode(danfeJson);
  }
}
