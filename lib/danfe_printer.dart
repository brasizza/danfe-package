import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'danfe.dart';

class DanfePrinter implements IDanfePrinter {
  final PaperSize paperSize;
  DanfePrinter(this.paperSize);

  ///
  ///  Metodo que vai pegar o objeto Danfe e converter em esc/pos em um layout pre determinado
  //
  @override
  Future<List<int>> bufferDanfe(Danfe? danfe,
      {bool mostrarMoeda = true}) async {
    String moeda = (mostrarMoeda == true) ? r'R$' : '';
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];
    // Print image
    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.text(
        danfe?.dados?.emit?.xFant ?? (danfe?.dados?.emit?.xNome ?? ''),
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
        ));
    bytes += generator.text((danfe?.dados?.emit?.cnpj ?? ''),
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(
        '${danfe?.dados?.emit?.enderEmit?.xLgr ?? ''}, ${danfe?.dados?.emit?.enderEmit?.nro ?? ''}',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.rawBytes([27, 97, 48]);
    bytes += generator.hr();
    bytes += generator.rawBytes([27, 97, 49]);
    if ((danfe?.tipo ?? 'CFe') == 'CFe') {
      bytes += generator.text('Nota Fiscal Eletronica - SAT ',
          styles: const PosStyles(
              align: PosAlign.center,
              bold: true,
              height: PosTextSize.size1,
              width: PosTextSize.size1));
    } else {
      bytes += generator.text('Nota Fiscal Eletronica - NFC-E ',
          styles: const PosStyles(
              align: PosAlign.center,
              bold: true,
              height: PosTextSize.size1,
              width: PosTextSize.size1));
    }
    bytes += generator.rawBytes([27, 97, 48]);
    bytes += generator.text(
        "CPF/CNPJ do consumidor: ${danfe?.dados?.dest?.cpf ?? ''}",
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text("Nota: ${danfe?.dados?.ide?.nNF ?? ''}",
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text(
        'Data: ${DanfeUtils.formatDate(danfe?.dados?.ide?.dataEmissao ?? '')}',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.hr();

    if (paperSize == PaperSize.mm58) {
      bytes += generator.row([
        PosColumn(
            text: 'DESCRICAO',
            width: 7,
            styles: const PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'QTD',
            width: 2,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
        PosColumn(
            text: 'VLTOT',
            width: 3,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
      ]);
    } else {
      bytes += generator.row([
        PosColumn(
            text: 'DESCRICAO',
            width: 5,
            styles: const PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'QTD',
            width: 1,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
        PosColumn(
            text: 'VLUN',
            width: 3,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
        PosColumn(
            text: 'VLTOT',
            width: 3,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
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
                    align: PosAlign.left, width: PosTextSize.size1)),
            PosColumn(
                text: DanfeUtils.formatNumber(det.prod?.qCom ?? ''),
                width: 2,
                styles: const PosStyles(align: PosAlign.right)),
            PosColumn(
                text: DanfeUtils.formatMoneyMilhar(det.prod?.vProd ?? '',
                    modeda: 'pt_BR', simbolo: moeda),
                width: 3,
                styles: const PosStyles(align: PosAlign.right)),
          ]);
        } else {
          bytes += generator.row([
            PosColumn(
                text: det.prod?.xProd ?? '',
                width: 5,
                styles: const PosStyles(align: PosAlign.left)),
            PosColumn(
                text: DanfeUtils.formatNumber(det.prod?.qCom ?? ''),
                width: 1,
                styles: const PosStyles(align: PosAlign.right)),
            PosColumn(
                text: DanfeUtils.formatMoneyMilhar(det.prod?.vUnCom ?? '',
                    modeda: 'pt_BR', simbolo: moeda),
                width: 3,
                styles: const PosStyles(align: PosAlign.right)),
            PosColumn(
                text: DanfeUtils.formatMoneyMilhar(det.prod?.vProd ?? '',
                    modeda: 'pt_BR', simbolo: moeda),
                width: 3,
                styles: const PosStyles(align: PosAlign.right)),
          ]);
        }
      }
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'QTD DE ITENS',
          width: 6,
          styles: const PosStyles(align: PosAlign.left)),
      PosColumn(
          text: DanfeUtils.formatNumber(
              danfe?.dados?.det?.length.toString() ?? ''),
          width: 6,
          styles: const PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1)),
    ]);
    bytes += generator.row([
      PosColumn(
          text: 'SUBTOTAL',
          width: 6,
          styles: const PosStyles(bold: true, align: PosAlign.left)),
      PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
              danfe?.dados?.total?.valorTotal ?? '',
              modeda: 'pt_BR',
              simbolo: moeda),
          width: 6,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);

    if ((danfe?.dados?.total?.desconto ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(
            text: 'DESCONTO',
            width: 6,
            styles: const PosStyles(align: PosAlign.left)),
        PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
                danfe?.dados?.total?.desconto ?? '',
                modeda: 'pt_BR',
                simbolo: moeda),
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
      ]);
    }

    if ((danfe?.dados?.total?.acrescimo ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(text: 'ACRESCIMO', width: 6, styles: const PosStyles()),
        PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
                danfe?.dados?.total?.acrescimo ?? '',
                modeda: 'pt_BR',
                simbolo: moeda),
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
      ]);
    }
    if ((danfe?.dados?.pgto?.vTroco ?? '0.00') != '0.00') {
      bytes += generator.row([
        PosColumn(
            text: 'TROCO',
            width: 6,
            styles: const PosStyles(align: PosAlign.left)),
        PosColumn(
            text: DanfeUtils.formatMoneyMilhar(danfe?.dados?.pgto?.vTroco ?? '',
                modeda: 'pt_BR', simbolo: moeda),
            width: 6,
            styles: const PosStyles(align: PosAlign.right)),
      ]);
    }

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(bold: true, align: PosAlign.left)),
      PosColumn(
          text: DanfeUtils.formatMoneyMilhar(
              danfe?.dados?.total?.valorPago ?? '0.00',
              modeda: 'pt_BR',
              simbolo: moeda),
          width: 6,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);
    bytes += generator.hr();
    if (danfe?.dados?.pgto != null) {
      bytes += generator.row([
        PosColumn(
            text: 'FORMAS DE PAGAMENTO',
            width: 6,
            styles: const PosStyles(bold: true)),
        PosColumn(
            text: 'VALOR PAGO',
            width: 6,
            styles: const PosStyles(align: PosAlign.right, bold: true)),
      ]);
      for (MP pagamento in danfe!.dados!.pgto!.formas!) {
        bytes += generator.row([
          PosColumn(
              text: pagamento.cMP ?? '',
              width: 6,
              styles: const PosStyles(align: PosAlign.left)),
          PosColumn(
              text: DanfeUtils.formatMoneyMilhar(pagamento.vMP ?? '',
                  modeda: 'pt_BR', simbolo: moeda),
              width: 6,
              styles: const PosStyles(align: PosAlign.right)),
        ]);
      }
      bytes += generator.hr();
    }

    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.text('CHAVE DE ACESSO DA NOTA FISCAL',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(
        DanfeUtils.splitByLength(danfe?.dados?.chaveNota ?? '', 4, ' '),
        styles: const PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.qrcode(danfe?.qrcodePrinter ?? '');

    bytes += generator.rawBytes([27, 97, 48]);
    bytes += generator.feed(1);

    if (danfe?.dados?.ide?.serie != null) {
      final serie = (danfe?.dados?.ide?.serie ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');
      bytes += generator.rawBytes([27, 97, 49]);

      bytes += generator.text('Nota $nnf Serie $serie ',
          styles: const PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.rawBytes([27, 97, 48]);

      bytes += generator.feed(1);
    }

    if (danfe?.dados?.ide?.nserieSAT != null) {
      final serie = (danfe?.dados?.ide?.nserieSAT ?? '0').padLeft(3, '0');
      final nnf = (danfe?.dados?.ide?.nNF ?? '0').padLeft(9, '0');
      bytes += generator.rawBytes([27, 97, 49]);
      bytes += generator.text('Nota $nnf Serie $serie',
          styles: const PosStyles(align: PosAlign.center, bold: true));
      bytes += generator.rawBytes([27, 97, 48]);

      bytes += generator.feed(1);
    }

    if (danfe?.protNFe != null) {
      bytes += generator.row([
        PosColumn(
            text: 'Protocolo: ', width: 6, styles: const PosStyles(bold: true)),
        PosColumn(
            text: danfe?.protNFe?.infProt?.nProt ?? '',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
      ]);
      DateTime dateTime = DateTime.parse(danfe?.protNFe?.infProt?.dhRecbto ??
          DateTime.now().toIso8601String());
      String formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";

      bytes += generator.row([
        PosColumn(
            text: 'Data: ', width: 6, styles: const PosStyles(bold: true)),
        PosColumn(
            text: formattedDate,
            width: 6,
            styles: const PosStyles(
              align: PosAlign.right,
            )),
      ]);
      bytes += generator.feed(1);
    }

    if (danfe?.dados?.infAdic?.infCpl != null) {
      bytes += generator.text(danfe!.dados!.infAdic!.infCpl ?? ' ',
          styles: const PosStyles(align: PosAlign.center));
    }

    bytes += generator.cut();
    bytes += generator.reset();

    return bytes;
  }
}
