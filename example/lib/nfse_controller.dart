import 'package:danfe/danfe.dart';
import 'package:esc_pos_printer_plus/esc_pos_printer_plus.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';

import 'custom_printer.dart';

class NfseController {
  Nfse? parseXml(String xml) {
    try {
      Nfse? danfe = NfseParser.readFromString(xml);
      return danfe;
    } catch (_) {
      return null;
    }
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer.asUint8List(
      fileData.offsetInBytes,
      fileData.lengthInBytes,
    );
    return fileUnit8List;
  }

  Future<void> printDefault({
    Nfse? danfe,
    required PaperSize paper,
    required CapabilityProfile profile,
  }) async {
    NfsePrinter danfePrinter = NfsePrinter(paper);
    List<int> dados = await danfePrinter.bufferNfse(
      danfe,
      mostrarMoeda: false,
    );
    NetworkPrinter printer = NetworkPrinter(paper, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.rawBytes(dados);
    printer.disconnect();
  }

  Future<void> printImage({
    required PaperSize paper,
    required CapabilityProfile profile,
  }) async {
    final profile = await CapabilityProfile.load();

    final ByteData data = await rootBundle.load('assets/images/danfe.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    img.Image image = img.decodeImage(bytes)!;
    image = img.grayscale(image);
    image = img.copyResize(
      image,
      width: 550,
    ); // Adjust the width as per your printer's max width

    NetworkPrinter printer = NetworkPrinter(paper, profile);
    await printer.connect('192.168.5.111', port: 9100);
    printer.reset();
    printer.imageRaster(image);
    printer.disconnect();
  }




  

  void printImagePos({required List<Image> images
, required PaperSize paper, required CapabilityProfile profile}) async  {
      NetworkPrinter printer = NetworkPrinter(paper, profile);
      await printer.connect('192.168.5.111', port: 9100);
      printer.reset();
       for (var image in images) {
       printer.imageRaster(image, align: PosAlign.left, );
           await Future.delayed(const Duration(milliseconds: 200));

    }
    printer.feed(2);
    printer.cut();
      printer.disconnect();
  } 
}
