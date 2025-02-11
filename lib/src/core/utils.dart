import 'package:intl/intl.dart';

/// A classe `DanfeUtils` fornece métodos utilitários para formatação e manipulação
/// de valores numéricos, monetários, datas e strings. É amplamente utilizada para
/// facilitar operações comuns relacionadas à manipulação de dados de DANFEs.
class DanfeUtils {
  /// Formata um número para um formato monetário, utilizando separadores de milhar e o símbolo da moeda.
  ///
  /// ### Parâmetros:
  /// - [number]: Uma `String` representando o número que será formatado.
  /// - [modeda] (opcional): Código do locale a ser utilizado na formatação, como `pt_BR`.
  ///   O valor padrão é uma string vazia.
  /// - [simbolo] (opcional): O símbolo da moeda, como `R$` ou `$`. O valor padrão é uma string vazia.
  ///
  /// ### Retorno:
  /// - Uma `String` contendo o número formatado com separadores de milhar e casas decimais.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.formatMoneyMilhar('1234.56', modeda: 'pt_BR', simbolo: 'R$');
  /// print(resultado); // Saída: R$1.234,56
  /// ```
  static formatMoneyMilhar(String number, {String modeda = '', String simbolo = ''}) {
    NumberFormat formatter = NumberFormat.currency(decimalDigits: 2, locale: modeda, symbol: simbolo);
    return formatter.format(double.parse(number));
  }

  /// Formata um número para remover os separadores de milhar e limitar as casas decimais.
  ///
  /// ### Parâmetros:
  /// - [number]: Uma `String` representando o número que será formatado.
  ///
  /// ### Retorno:
  /// - Uma `String` contendo o número formatado com até duas casas decimais.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.formatNumber('1234.567');
  /// print(resultado); // Saída: 1234.57
  /// ```
  static String formatNumber(String number) {
    String result;
    result = NumberFormat('###.##').format(double.parse(number));
    return result;
  }

  /// Formata uma data em formato ISO (YYYY-MM-DD) para um formato legível, com opção de incluir
  /// apenas a data ou também a hora.
  ///
  /// ### Parâmetros:
  /// - [date]: Uma `String` representando a data no formato ISO.
  /// - [dateOnly] (opcional): Define se apenas a data será exibida. O valor padrão é `false`.
  ///
  /// ### Retorno:
  /// - Uma `String` contendo a data formatada.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.formatDate('2025-01-20T14:30:00');
  /// print(resultado); // Saída: 20/01/2025 14:30:00
  ///
  /// String resultadoData = DanfeUtils.formatDate('2025-01-20', dateOnly: true);
  /// print(resultadoData); // Saída: 20/01/2025
  /// ```
  static String formatDate(String date, {bool dateOnly = false}) {
    DateTime data = DateTime.parse(date);
    var outputFormat = (dateOnly == true) ? DateFormat('dd/MM/yyyy') : DateFormat('dd/MM/yyyy HH:mm:ss');
    return outputFormat.format(data);
  }

  /// Divide uma string em partes de um comprimento especificado, com a opção de adicionar um separador entre as partes.
  ///
  /// ### Parâmetros:
  /// - [value]: Uma `String` que será dividida.
  /// - [length]: Um `int` representando o comprimento de cada pedaço.
  /// - [glue] (opcional): Uma `String` usada como separador entre as partes. O valor padrão é um espaço (`' '`).
  ///
  /// ### Retorno:
  /// - Uma `String` contendo os pedaços da string original, unidos pelo separador especificado.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.splitByLength('1234567890', 3, '-');
  /// print(resultado); // Saída: 123-456-789-0
  /// ```
  static String splitByLength(String value, int length, [String glue = ' ']) {
    List<String> pieces = [];

    for (int i = 0; i < value.length; i += length) {
      int offset = i + length;
      pieces.add(value.substring(i, offset >= value.length ? value.length : offset));
    }
    return pieces.join(glue);
  }
}
