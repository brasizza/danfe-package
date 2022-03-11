import 'package:intl/intl.dart';

class DanfeUtils {
  ///
  ///Conversor de string para moeda para ficar melhor formatado
  ///
  static formatMoneyMilhar(String number, {String modeda = '', String simbolo = ''}) {
    NumberFormat formatter = NumberFormat.currency(decimalDigits: 2, locale: modeda, symbol: simbolo);
    return formatter.format(double.parse(number));
  }

  ///
  ///Conversor simples de numeros para utiliar a virgula
  ///
  static String formatNumber(String number) {
    String result;
    result = NumberFormat('###.##').format(double.parse(number));
    return result;
    // NumberFormat();
  }

  static String formatDate(String date, {bool dateOnly = false}) {
    DateTime data = DateTime.parse(date);
    var outputFormat = (dateOnly == true) ? DateFormat('dd/MM/yyyy') : DateFormat('dd/MM/yyyy HH:mm:ss');
    return outputFormat.format(data);
  }

  ///
  /// Metodo para separar os números da chave da nota
  ///
  static String splitByLength(String value, int length, [String glue = ' ']) {
    List<String> pieces = [];

    for (int i = 0; i < value.length; i += length) {
      int offset = i + length;
      pieces.add(value.substring(i, offset >= value.length ? value.length : offset));
    }
    return pieces.join(glue);
  }
}
