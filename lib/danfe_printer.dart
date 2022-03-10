import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';

class DanfePrinter {
  final PaperSize paperSize;
  DanfePrinter(this.paperSize);
  String formatMoneyMilhar(String number, {String modeda = '', String simbolo = ''}) {
    NumberFormat formatter = NumberFormat.currency(decimalDigits: 2, locale: modeda, symbol: simbolo);
    return formatter.format(double.parse(number));
  }

  String formatNumber(String number) {
    String result;
    result = NumberFormat('###.##').format(double.parse(number));
    return result;
    // NumberFormat();
  }

  String splitByLength(String value, int length, [String glue = ' ']) {
    List<String> pieces = [];

    for (int i = 0; i < value.length; i += length) {
      int offset = i + length;
      pieces.add(value.substring(i, offset >= value.length ? value.length : offset));
    }
    return pieces.join(glue);
  }

  Future<List<int>> bufferDanfe(Danfe? danfe) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];
    // Print image
    bytes += generator.rawBytes([27, 97, 49]);

    bytes += generator.text(danfe?.dados?.emit?.xFant ?? '',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.feed(1);

    bytes += generator.text((danfe?.dados?.emit?.cnpj ?? ''), styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text((danfe?.dados?.emit?.enderEmit?.xLgr ?? '') + ', ' + ((danfe?.dados?.emit?.enderEmit?.nro ?? '')), styles: const PosStyles(align: PosAlign.center));
    bytes += generator.hr();
    if ((danfe?.tipo ?? 'CFe') == 'CFe') {
      bytes += generator.text('Nota Fiscal Eletronica - SAT ', styles: const PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size1, width: PosTextSize.size1), linesAfter: 1);
    } else {
      bytes += generator.text('Nota Fiscal Eletronica - NFC-E ',
          styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          ),
          linesAfter: 1);
    }

    bytes += generator.rawBytes([27, 97, 48]);
    bytes += generator.text("CPF/CNPJ do consumidor: " + (danfe?.dados?.dest?.cpf ?? ''), styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text("Nota : " + (danfe?.dados?.ide?.nNF ?? ''), styles: const PosStyles(align: PosAlign.left));
    bytes += generator.feed(1);
    bytes += generator.setStyles(const PosStyles(fontType: PosFontType.fontB));
    bytes += generator.row([
      PosColumn(text: 'DESCRICAO', width: (paperSize == PaperSize.mm58) ? 3 : 5),
      PosColumn(text: 'QTD', width: ((paperSize == PaperSize.mm58) ? 3 : 1), styles: const PosStyles(align: PosAlign.right)),
      PosColumn(text: 'VLUN', width: 3, styles: const PosStyles(align: PosAlign.right)),
      PosColumn(text: 'VLTOT', width: 3, styles: const PosStyles(align: PosAlign.right)),
    ]);
    if (danfe?.dados?.det != null) {
      for (Det det in danfe!.dados!.det!) {
        bytes += generator.row([
          PosColumn(text: det.prod?.xProd ?? '', width: (paperSize == PaperSize.mm58) ? 3 : 5),
          PosColumn(text: formatNumber(det.prod?.qCom ?? ''), width: ((paperSize == PaperSize.mm58) ? 3 : 1), styles: const PosStyles(align: PosAlign.right)),
          PosColumn(text: formatMoneyMilhar(det.prod?.vUnCom ?? '', modeda: 'pt_BR', simbolo: r'R$'), width: 3, styles: const PosStyles(align: PosAlign.right)),
          PosColumn(text: formatMoneyMilhar(det.prod?.vProd ?? '', modeda: 'pt_BR', simbolo: r'R$'), width: 3, styles: const PosStyles(align: PosAlign.right)),
        ]);
      }
    }

    bytes += generator.hr();
    if (danfe?.dados?.pgto != null) {
      for (MP pagamento in danfe!.dados!.pgto!.formas!) {
        bytes += generator.row([
          PosColumn(
              text: pagamento.cMP ?? '',
              width: 6,
              styles: const PosStyles(
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
          PosColumn(
              text: formatMoneyMilhar(pagamento.vMP ?? '', modeda: 'pt_BR', simbolo: r'R$'),
              width: 6,
              styles: const PosStyles(
                align: PosAlign.right,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
        ]);
      }

      if ((danfe.dados?.total?.desconto ?? '0.00') != '0.00') {
        bytes += generator.row([
          PosColumn(
              text: 'Desconto',
              width: 6,
              styles: const PosStyles(
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
          PosColumn(
              text: formatMoneyMilhar(danfe.dados?.total?.desconto ?? '', modeda: 'pt_BR', simbolo: r'R$'),
              width: 6,
              styles: const PosStyles(
                align: PosAlign.right,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
        ]);
      }

      if ((danfe.dados?.pgto?.vTroco ?? '0.00') != '0.00') {
        bytes += generator.row([
          PosColumn(
              text: 'Troco',
              width: 6,
              styles: const PosStyles(
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
          PosColumn(
              text: formatMoneyMilhar(danfe.dados?.pgto?.vTroco ?? '', modeda: 'pt_BR', simbolo: r'R$'),
              width: 6,
              styles: const PosStyles(
                align: PosAlign.right,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
        ]);
      }
    }

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
      PosColumn(
          text: formatMoneyMilhar(danfe?.dados?.total?.valorTotal ?? '', modeda: 'pt_BR', simbolo: r'R$'),
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )),
    ]);

    bytes += generator.hr();
    bytes += generator.setStyles(const PosStyles(fontType: PosFontType.fontA));
    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.text('CHAVE DE ACESSO DA NOTA FISCAL', styles: const PosStyles(align: PosAlign.center));

    bytes += generator.text(splitByLength(danfe?.dados?.chaveNota ?? '', 4, ' '), styles: const PosStyles(align: PosAlign.center, bold: true));

    DateTime data = DateTime.now();
    bytes += generator.rawBytes([27, 97, 48]);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    String dataEmissao = outputFormat.format(data);
    bytes += generator.text('Emitida em: ' + dataEmissao, styles: const PosStyles(align: PosAlign.center));
    bytes += generator.feed(1);
    bytes += generator.rawBytes([27, 97, 49]);
    bytes += generator.qrcode(danfe?.qrcodePrinter ?? '');
    bytes += generator.rawBytes([27, 97, 48]);
    if (danfe?.dados?.infAdic?.infCpl != null) {
      bytes += generator.text(danfe!.dados!.infAdic!.infCpl ?? ' ', styles: const PosStyles(align: PosAlign.center));
    }

    bytes += generator.feed(1);
    bytes += generator.cut();
    bytes += generator.reset();

    return bytes;
  }
}
