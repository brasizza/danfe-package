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
  static String formatMoneyMilhar(String number,
      {String modeda = '', String simbolo = ''}) {
    NumberFormat formatter = NumberFormat.currency(
      decimalDigits: 2,
      symbol: '',
      locale: modeda,
    );
    final formatterSymbol = formatter.format(double.parse(number));

    return '$simbolo${formatterSymbol.trim()}';
  }

  /// Remove acentos de uma string, substituindo caracteres acentuados por suas versões sem acento.
  ///
  /// ### Parâmetros:
  /// - [text]: Uma `String` contendo caracteres acentuados.
  ///
  /// ### Retorno:
  /// - Uma `String` sem caracteres acentuados.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.removeAccents("Olá, mundo!");
  /// print(resultado); // Saída: Ola, mundo!
  /// ```
  static String removeAcentos(String text) {
    const Map<String, String> accentMap = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'ä': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ì': 'i',
      'î': 'i',
      'ï': 'i',
      'ó': 'o',
      'ò': 'o',
      'õ': 'o',
      'ô': 'o',
      'ö': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ü': 'u',
      'ç': 'c',
      'ñ': 'n',
      'Á': 'A',
      'À': 'A',
      'Ã': 'A',
      'Â': 'A',
      'Ä': 'A',
      'É': 'E',
      'È': 'E',
      'Ê': 'E',
      'Ë': 'E',
      'Í': 'I',
      'Ì': 'I',
      'Î': 'I',
      'Ï': 'I',
      'Ó': 'O',
      'Ò': 'O',
      'Õ': 'O',
      'Ô': 'O',
      'Ö': 'O',
      'Ú': 'U',
      'Ù': 'U',
      'Û': 'U',
      'Ü': 'U',
      'Ç': 'C',
      'Ñ': 'N'
    };

    return text.split('').map((char) => accentMap[char] ?? char).join();
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
    return NumberFormat('###.##').format(double.parse(number));
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
    var outputFormat =
        dateOnly ? DateFormat('dd/MM/yyyy') : DateFormat('dd/MM/yyyy HH:mm:ss');
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
      pieces.add(
          value.substring(i, offset >= value.length ? value.length : offset));
    }
    return pieces.join(glue);
  }

  /// Formata um CPF no padrão `XXX.XXX.XXX-XX`.
  ///
  /// ### Parâmetros:
  /// - [cpf]: Uma `String` contendo apenas os números do CPF.
  ///
  /// ### Retorno:
  /// - Uma `String` formatada no padrão CPF.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.formatCPF("12345678901");
  /// print(resultado); // Saída: 123.456.789-01
  /// ```
  static String formatCPF(String cpf) {
    if (cpf.length != 11) return cpf;
    return "${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}";
  }

  /// Formata um CNPJ no padrão `XX.XXX.XXX/XXXX-XX`.
  ///
  /// ### Parâmetros:
  /// - [cnpj]: Uma `String` contendo apenas os números do CNPJ.
  ///
  /// ### Retorno:
  /// - Uma `String` formatada no padrão CNPJ.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String resultado = DanfeUtils.formatCNPJ("12345678000195");
  /// print(resultado); // Saída: 12.345.678/0001-95
  /// ```
  static String formatCNPJ(String cnpj) {
    if (cnpj.length != 14) return cnpj;
    return "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12)}";
  }

  static String formatCep(String cep) {
    if (cep.length != 8) return cep;
    return "${cep.substring(0, 5)}-${cep.substring(5)}";
  }
}
