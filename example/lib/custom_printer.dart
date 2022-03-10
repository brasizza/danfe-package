import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class CustomPrinter extends DanfePrinter {
  CustomPrinter(PaperSize paperSize) : super(paperSize);

  Future<List<int>> layoutCustom(Danfe? danfe) async {
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
    bytes += generator.text(
        'Chave: ' + splitByLength(danfe?.dados?.chaveNota ?? ' ', 4, '-'));
    bytes += generator.cut();
    return bytes;
  }
}
