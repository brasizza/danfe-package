import 'dart:convert';

/// A classe `Ide` representa as informações de identificação (IDE) de um documento fiscal.
///
/// ### Funcionalidades:
/// - Suporte à conversão para mapas (`Map<String, dynamic>`) e JSON.
/// - Permite inicialização a partir de mapas e strings JSON.
/// - Processamento e formatação de data e hora da emissão do documento.
class Ide {
  /// Código da UF do emitente.
  String? cUF;

  /// Código numérico da nota.
  String? cNF;

  /// Modelo do documento fiscal.
  String? mod;

  /// Número de série do equipamento SAT.
  String? nserieSAT;

  /// Série do documento fiscal.
  String? serie;

  /// Data de emissão no formato AAAAMMDD.
  String? dEmi;

  /// Hora de emissão no formato HHMMSS.
  String? hEmi;

  /// Dígito verificador do código da chave de acesso.
  String? cDV;

  /// Tipo de ambiente (1 = Produção, 2 = Homologação).
  String? tpAmb;

  /// CNPJ do emitente.
  String? cNPJ;

  /// Assinatura do AC para o SAT.
  String? signAC;

  /// Assinatura do QR Code.
  String? assinaturaQRCODE;

  /// Número do caixa.
  String? numeroCaixa;

  /// Número da nota fiscal.
  String? nNF;

  /// Data e hora de emissão no formato UTC.
  String? dhEmi;

  /// Data e hora de emissão formatada (AAAA-MM-DD HH:MM:SS).
  String? dataEmissao;

  /// Data e hora de saida formatada (AAAA-MM-DD HH:MM:SS).

  String? dhSaiEnt;

  /// Construtor da classe `Ide`.
  ///
  /// ### Parâmetros:
  /// - [cUF]: Código da UF.
  /// - [cNF]: Código numérico da nota.
  /// - [mod]: Modelo do documento fiscal.
  /// - [nserieSAT]: Número de série do SAT.
  /// - [serie]: Série do documento fiscal.
  /// - [dEmi]: Data de emissão (AAAAMMDD).
  /// - [hEmi]: Hora de emissão (HHMMSS).
  /// - [cDV]: Dígito verificador.
  /// - [tpAmb]: Tipo de ambiente.
  /// - [cNPJ]: CNPJ do emitente.
  /// - [signAC]: Assinatura do AC.
  /// - [assinaturaQRCODE]: Assinatura do QR Code.
  /// - [numeroCaixa]: Número do caixa.
  /// - [nNF]: Número da nota fiscal.
  /// - [dhEmi]: Data e hora de emissão (UTC).
  /// - [dataEmissao]: Data e hora formatadas.
  /// - [dhSaiEnt]: Data e hora formatadas.
  Ide({
    this.cUF,
    this.cNF,
    this.mod,
    this.nserieSAT,
    this.serie,
    this.dEmi,
    this.hEmi,
    this.cDV,
    this.tpAmb,
    this.cNPJ,
    this.signAC,
    this.assinaturaQRCODE,
    this.numeroCaixa,
    this.nNF,
    this.dhEmi,
    this.dataEmissao,
    this.dhSaiEnt,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa contendo os valores das propriedades de `Ide`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Ide ide = Ide(cUF: '35', cNF: '12345');
  /// Map<String, dynamic> mapa = ide.toMap();
  /// print(mapa); // Saída: {cUF: 35, cNF: 12345}
  /// ```
  Map<String, dynamic> toMap() {
    return {
      'cUF': cUF,
      'cNF': cNF,
      'mod': mod,
      'nserieSAT': nserieSAT,
      'serie': serie,
      'dEmi': dEmi,
      'hEmi': hEmi,
      'cDV': cDV,
      'nNF': nNF,
      'dhEmi': dhEmi,
      'tpAmb': tpAmb,
      'cNPJ': cNPJ,
      'signAC': signAC,
      'assinaturaQRCODE': assinaturaQRCODE,
      'numeroCaixa': numeroCaixa,
      'dhSaiEnt': dhSaiEnt,
    };
  }

  /// Cria uma instância de `Ide` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades de `Ide`.
  ///
  /// ### Retorno:
  /// - Uma instância de `Ide` populada com os valores fornecidos no mapa.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Map<String, dynamic> mapa = {'cUF': '35', 'cNF': '12345'};
  /// Ide ide = Ide.fromMap(mapa);
  /// print(ide.cUF); // Saída: 35
  /// ```
  factory Ide.fromMap(Map<String, dynamic> map) {
    Ide ide = Ide(
      cUF: map['cUF'],
      cNF: map['cNF'],
      mod: map['mod'],
      nserieSAT: map['nserieSAT'],
      serie: map['serie'],
      dEmi: map['dEmi'],
      hEmi: map['hEmi'],
      cDV: map['cDV'],
      tpAmb: map['tpAmb'],
      cNPJ: map['CNPJ'],
      signAC: map['signAC'],
      assinaturaQRCODE: map['assinaturaQRCODE'],
      numeroCaixa: map['numeroCaixa'],
      nNF: map.containsKey('nCFe') ? map['nCFe'] : map['nNF'],
      dhEmi: map['dhEmi'],
      dhSaiEnt: map['dhSaiEnt'],
    );

    if (map.containsKey('dEmi')) {
      String parsedDate =
          ('${(map['dEmi'] as String).substring(0, 4)}-${(map['dEmi'] as String).substring(4, 6)}-${(map['dEmi'] as String).substring(6, 8)}');
      String parsedHour =
          '${(map['hEmi'] as String).substring(0, 2)}:${(map['hEmi'] as String).substring(2, 4)}:${(map['hEmi'] as String).substring(4, 6)}';
      ide.dataEmissao = "$parsedDate $parsedHour";
    } else if (map.containsKey('dhEmi')) {
      DateTime data = DateTime.parse((map['dhEmi']));
      String dataEmissao =
          "${data.year.toString()}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')} ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}:${data.second.toString().padLeft(2, '0')}";
      ide.dataEmissao = dataEmissao;
    }

    return ide;
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON contendo os dados de `Ide`.
  ///
  /// ### Exemplo:
  /// ```dart
  /// Ide ide = Ide(cUF: '35', cNF: '12345');
  /// String json = ide.toJson();
  /// print(json); // Saída: {"cUF":"35","cNF":"12345"}
  /// ```
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `Ide` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `Ide` populada com os valores fornecidos na string JSON.
  ///
  /// ### Exemplo:
  /// ```dart
  /// String json = '{"cUF":"35","cNF":"12345"}';
  /// Ide ide = Ide.fromJson(json);
  /// print(ide.cNF); // Saída: 12345
  /// ```
  factory Ide.fromJson(String source) => Ide.fromMap(json.decode(source));
}
