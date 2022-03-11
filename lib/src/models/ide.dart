import 'dart:convert';

class Ide {
  String? cUF;
  String? cNF;
  String? mod;
  String? nserieSAT;
  String? dEmi;
  String? hEmi;
  String? cDV;
  String? tpAmb;
  String? cNPJ;
  String? signAC;
  String? assinaturaQRCODE;
  String? numeroCaixa;
  String? nNF;
  String? dhEmi;
  String? dataEmissao;

  Ide(
      {this.cUF,
      this.cNF,
      this.mod,
      this.nserieSAT,
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
      this.dataEmissao});

  Map<String, dynamic> toMap() {
    return {
      'cUF': cUF,
      'cNF': cNF,
      'mod': mod,
      'nserieSAT': nserieSAT,
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
    };
  }

  factory Ide.fromMap(Map<String, dynamic> map) {
    Ide ide = Ide(
      cUF: map['cUF'],
      cNF: map['cNF'],
      mod: map['mod'],
      nserieSAT: map['nserieSAT'],
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
    );

    if (map.containsKey('dEmi')) {
      String parsedDate = ((map['dEmi'] as String).substring(0, 4) +
          '-' +
          (map['dEmi'] as String).substring(4, 6) +
          '-' +
          (map['dEmi'] as String).substring(6, 8));
      String parsedHour = (map['hEmi'] as String).substring(0, 2) +
          ':' +
          (map['hEmi'] as String).substring(2, 4) +
          ':' +
          (map['hEmi'] as String).substring(4, 6);
      ide.dataEmissao = "$parsedDate $parsedHour";
    } else if (map.containsKey('dhEmi')) {
      DateTime data = DateTime.parse((map['dhEmi']));
      String dataEmissao =
          "${data.year.toString()}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')} ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}:${data.second.toString().padLeft(2, '0')}";
      ide.dataEmissao = dataEmissao;
    }

    return ide;
  }

  String toJson() => json.encode(toMap());

  factory Ide.fromJson(String source) => Ide.fromMap(json.decode(source));
}
