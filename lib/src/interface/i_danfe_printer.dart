import '../../danfe.dart';

abstract class IDanfePrinter {
  ///
  /// Implementa a interface para todos ficarem com o  mesmo método para customizacao
  ///
  Future<List<int>> bufferDanfe(Danfe? danfe, {bool mostrarMoeda = true});
}
