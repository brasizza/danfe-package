import 'package:danfe/danfe.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'custom_printer.dart';

class HomeController {
  Danfe? parseXml(String xml) {
    try {
      Danfe? danfe = DanfeParser.readFromString(xml);
      return danfe;
    } catch (_) {
      return null;
    }
  }

  String normativeJson(
    String xml,
    PaperSize paper,
  ) {
    DanfePrinter danfePrinter = DanfePrinter(paper);
    Danfe? danfe = DanfeParser.readFromString(xml);

    return danfePrinter.normativeJsonDanfe(danfe);
  }

  Future<void> printDefault(
      {Danfe? danfe,
      required PaperSize paper,
      required CapabilityProfile profile}) async {
    DanfePrinter danfePrinter = DanfePrinter(paper);
    List<int> dados =
        await danfePrinter.bufferDanfe(danfe, mostrarMoeda: false);
    NetworkPrinter printer = NetworkPrinter(paper, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.rawBytes(dados);
    printer.disconnect();
  }

  printCustomLayout(
      {Danfe? danfe,
      required PaperSize paper,
      required CapabilityProfile profile}) async {
    final CustomPrinter custom = CustomPrinter(paper);
    List<int> dados = await custom.bufferDanfe(danfe);
    NetworkPrinter printer = NetworkPrinter(paper, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.rawBytes(dados);
    printer.disconnect();
  }
}
