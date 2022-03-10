import 'package:danfe/danfe.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class HomeController {
  Danfe? parseXml(String xml) {
    try {
      Danfe? danfe = DanfeParser.readFromString(xml);
      return danfe;
    } catch (_) {
      return null;
    }
  }

  Future<void> printDefault(Danfe? danfe, PaperSize paper) async {
    DanfePrinter danfePrinter = DanfePrinter(paper);
    final profile = await CapabilityProfile.load();
    List<int> _dados = await danfePrinter.bufferDanfe(danfe);
    NetworkPrinter printer = NetworkPrinter(paper, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.rawBytes(_dados);
    printer.disconnect();
  }

  printCustom(Danfe? danfe, PaperSize paperSize) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];
    bytes += generator.text(danfe?.dados?.emit?.xFant ?? '',
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.feed(1);

    bytes += generator.text((danfe?.dados?.emit?.cnpj ?? ''),
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Nota compacta',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.qrcode(danfe?.qrcodePrinter ?? ' ');
    bytes += generator.text('Chave: ' + (danfe?.dados?.chaveNota ?? ' '));
    bytes += generator.cut();
    NetworkPrinter printer = NetworkPrinter(paperSize, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.rawBytes(bytes);
    printer.disconnect();
  }
}
