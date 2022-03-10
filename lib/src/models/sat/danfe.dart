import 'dart:convert';

class Danfe {
  DadosDanfe? dados;
  String tipo;
  InfNFeSupl? infNFeSupl;
  ProtNFe? protNFe;
  String? qrcodePrinter;
  Danfe({
    this.dados,
    required this.tipo,
    this.infNFeSupl,
    this.protNFe,
  });

  Map<String, dynamic> toMap() {
    return {
      'dados': dados?.toMap(),
    };
  }

  factory Danfe.fromMapSat(Map<String, dynamic> map) {
    Danfe _danfe = Danfe(dados: map['infCFe'] != null ? DadosDanfe.fromMap(map['infCFe']) : null, tipo: 'CFe');
    // String qrcode = (_danfe.dados?.chaveNota?.replaceAll('CFe', '') ?? '') + '|' + (_danfe.dados?.ide?.dEmi ?? '') + (_danfe.dados?.ide?.hEmi ?? '') + '|' + (_danfe.dados?.total?.valorTotal ?? '') + '|' + (_danfe.dados?.dest?.cpf ?? '') + '|' + (_danfe.dados?.ide?.assinaturaQRCODE ?? '');
    String qrcode = (_danfe.dados?.ide?.assinaturaQRCODE ?? '');
    _danfe.qrcodePrinter = qrcode.substring(100);
    return _danfe;
  }

  factory Danfe.fromMapNFce(Map<String, dynamic> map) {
    Danfe _danfe = Danfe(
      dados: map['NFe']['infNFe'] != null ? DadosDanfe.fromMap(map['NFe']['infNFe']) : null,
      tipo: 'NFe',
      protNFe: map['protNFe'] != null ? ProtNFe.fromMap(map['protNFe']) : null,
      infNFeSupl: map['NFe']['infNFeSupl'] != null ? InfNFeSupl.fromMap(map['NFe']['infNFeSupl']) : null,
    );
    _danfe.qrcodePrinter = _danfe.infNFeSupl?.qrCode;
    return _danfe;
  }

  String toJson() => json.encode(toMap());
}

class InfNFeSupl {
  String? qrCode;
  String? urlChave;

  InfNFeSupl({
    this.qrCode,
    this.urlChave,
  });

  Map<String, dynamic> toMap() {
    return {
      'qrCode': qrCode,
      'urlChave': urlChave,
    };
  }

  factory InfNFeSupl.fromMap(Map<String, dynamic> map) {
    return InfNFeSupl(
      qrCode: map['qrCode'],
      urlChave: map['urlChave'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfNFeSupl.fromJson(String source) => InfNFeSupl.fromMap(json.decode(source));
}

class ProtNFe {
  String? sVersao;
  InfProt? infProt;

  ProtNFe({this.sVersao, this.infProt});

  Map<String, dynamic> toMap() {
    return {
      'sVersao': sVersao,
      'infProt': infProt?.toMap(),
    };
  }

  factory ProtNFe.fromMap(Map<String, dynamic> map) {
    return ProtNFe(
      sVersao: map['_versao'],
      infProt: map['infProt'] != null ? InfProt.fromMap(map['infProt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProtNFe.fromJson(String source) => ProtNFe.fromMap(json.decode(source));
}

class InfProt {
  String? tpAmb;
  String? verAplic;
  String? chNFe;
  String? dhRecbto;
  String? nProt;
  String? digVal;
  String? cStat;
  String? xMotivo;

  InfProt({this.tpAmb, this.verAplic, this.chNFe, this.dhRecbto, this.nProt, this.digVal, this.cStat, this.xMotivo});

  Map<String, dynamic> toMap() {
    return {
      'tpAmb': tpAmb,
      'verAplic': verAplic,
      'chNFe': chNFe,
      'dhRecbto': dhRecbto,
      'nProt': nProt,
      'digVal': digVal,
      'cStat': cStat,
      'xMotivo': xMotivo,
    };
  }

  factory InfProt.fromMap(Map<String, dynamic> map) {
    return InfProt(
      tpAmb: map['tpAmb'],
      verAplic: map['verAplic'],
      chNFe: map['chNFe'],
      dhRecbto: map['dhRecbto'],
      nProt: map['nProt'],
      digVal: map['digVal'],
      cStat: map['cStat'],
      xMotivo: map['xMotivo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfProt.fromJson(String source) => InfProt.fromMap(json.decode(source));
}

class DadosDanfe {
  Ide? ide;
  Emit? emit;
  Dest? dest;
  List<Det>? det;
  Total? total;
  Pgto? pgto;
  InfAdic? infAdic;
  String? chaveNota;
  String? sVersao;
  String? sVersaoDadosEnt;
  String? sVersaoSB;

  DadosDanfe({this.ide, this.emit, this.dest, this.det, this.total, this.pgto, this.infAdic, this.chaveNota, this.sVersao, this.sVersaoDadosEnt, this.sVersaoSB});

  Map<String, dynamic> toMap() {
    return {
      'ide': ide?.toMap(),
      'emit': emit?.toMap(),
      'dest': dest?.toMap(),
      'det': det?.map((x) => x.toMap()).toList(),
      'total': total?.toMap(),
      'pgto': pgto?.toMap(),
      'infAdic': infAdic?.toMap(),
      'chaveNota': chaveNota,
      'sVersao': sVersao,
      'sVersaoDadosEnt': sVersaoDadosEnt,
      'sVersaoSB': sVersaoSB,
    };
  }

  factory DadosDanfe.fromMap(Map<String, dynamic> map) {
    List<Det> _det = [];
    if (map['det'].runtimeType.toString() != 'List<dynamic>') {
      _det.add(Det.fromMap(map['det']));
    } else {
      _det.addAll(List<Det>.from(map['det']?.map((x) => Det.fromMap(x))));
    }
    return DadosDanfe(
      ide: map['ide'] != null ? Ide.fromMap(map['ide']) : null,
      emit: map['emit'] != null ? Emit.fromMap(map['emit']) : null,
      dest: map['dest'] != null ? Dest.fromMap(map['dest']) : null,
      det: map['det'] != null ? _det : null,
      total: map['total'] != null ? Total.fromMap(map['total']) : null,
      pgto: (map['pgto'] != null || map['pag'] != null) ? Pgto.fromMap(map.containsKey('pgto') ? map['pgto'] : map['pag']) : null,
      infAdic: map['infAdic'] != null ? InfAdic.fromMap(map['infAdic']) : null,
      chaveNota: (map['_Id'] as String).replaceAll('CFe', '').replaceAll('NFe', ''),
      sVersao: map['_versao'],
      sVersaoDadosEnt: map['_versaoDadosEnt'],
      sVersaoSB: map['_versaoSB'],
    );
  }
  String toJson() => json.encode(toMap());
  factory DadosDanfe.fromJson(String source) => DadosDanfe.fromMap(json.decode(source));
}

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

  Ide({this.cUF, this.cNF, this.mod, this.nserieSAT, this.dEmi, this.hEmi, this.cDV, this.tpAmb, this.cNPJ, this.signAC, this.assinaturaQRCODE, this.numeroCaixa, this.nNF, this.dhEmi});

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
    return Ide(
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
  }

  String toJson() => json.encode(toMap());

  factory Ide.fromJson(String source) => Ide.fromMap(json.decode(source));
}

class EnderEmit {
  String? xLgr;
  String? nro;
  String? xCpl;
  String? xBairro;
  String? cMun;
  String? xMun;
  String? uF;
  String? cEP;
  String? cPais;
  String? xPais;
  String? fone;

  EnderEmit({this.xLgr, this.nro, this.xCpl, this.xBairro, this.cMun, this.xMun, this.uF, this.cEP, this.cPais, this.xPais, this.fone});

  Map<String, dynamic> toMap() {
    return {
      'xLgr': xLgr,
      'nro': nro,
      'xCpl': xCpl,
      'xBairro': xBairro,
      'cMun': cMun,
      'xMun': xMun,
      'uF': uF,
      'cEP': cEP,
      'cPais': cPais,
      'xPais': xPais,
      'fone': fone,
    };
  }

  factory EnderEmit.fromMap(Map<String, dynamic> map) {
    return EnderEmit(
      xLgr: map['xLgr'],
      nro: map['nro'],
      xCpl: map['xCpl'],
      xBairro: map['xBairro'],
      cMun: map['cMun'],
      xMun: map['xMun'],
      uF: map['UF'],
      cEP: map['CEP'],
      cPais: map['cPais'],
      xPais: map['xPais'],
      fone: map['fone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderEmit.fromJson(String source) => EnderEmit.fromMap(json.decode(source));
}

class Emit {
  String? cnpj;
  String? xNome;
  String? xFant;
  String? iE;
  String? iM;
  String? cRegTrib;
  String? indRatISSQN;
  EnderEmit? enderEmit;
  Emit({this.cnpj, this.xNome, this.xFant, this.iE, this.iM, this.cRegTrib, this.indRatISSQN, this.enderEmit});

  Map<String, dynamic> toMap() {
    return {
      'cnpj': cnpj,
      'xNome': xNome,
      'xFant': xFant,
      'iE': iE,
      'iM': iM,
      'cRegTrib': cRegTrib,
      'indRatISSQN': indRatISSQN,
      'enderEmit': enderEmit?.toMap(),
    };
  }

  factory Emit.fromMap(Map<String, dynamic> map) {
    return Emit(
      cnpj: map['CNPJ'],
      xNome: map['xNome'],
      xFant: map['xFant'],
      iE: map['IE'],
      iM: map['IM'],
      cRegTrib: map['cRegTrib'],
      indRatISSQN: map['indRatISSQN'],
      enderEmit: map['enderEmit'] != null ? EnderEmit.fromMap(map['enderEmit']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Emit.fromJson(String source) => Emit.fromMap(json.decode(source));
}

class Dest {
  String? cpf;
  String? xNome;
  Dest({this.cpf, this.xNome});

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'xNome': xNome,
    };
  }

  factory Dest.fromMap(Map<String, dynamic> map) {
    return Dest(
      cpf: map['CPF'],
      xNome: map['xNome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dest.fromJson(String source) => Dest.fromMap(json.decode(source));
}

class Det {
  Prod? prod;
  String? sNItem;
  Det({this.prod, this.sNItem});

  Map<String, dynamic> toMap() {
    return {
      'prod': prod?.toMap(),
      'sNItem': sNItem,
    };
  }

  factory Det.fromMap(Map<String, dynamic> map) {
    return Det(
      prod: map['prod'] != null ? Prod.fromMap(map['prod']) : null,
      sNItem: map['_nItem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Det.fromJson(String source) => Det.fromMap(json.decode(source));
}

class Prod {
  String? cProd;
  String? xProd;
  String? nCM;
  String? cFOP;
  String? uCom;
  String? qCom;
  String? vUnCom;
  String? vProd;
  String? indRegra;
  String? vItem;
  String? vDesc;
  Prod({this.cProd, this.xProd, this.nCM, this.cFOP, this.uCom, this.qCom, this.vUnCom, this.vProd, this.indRegra, this.vItem, this.vDesc});

  Map<String, dynamic> toMap() {
    return {
      'cProd': cProd,
      'xProd': xProd,
      'nCM': nCM,
      'cFOP': cFOP,
      'uCom': uCom,
      'qCom': qCom,
      'vUnCom': vUnCom,
      'vProd': vProd,
      'indRegra': indRegra,
      'vItem': vItem,
      'vDesc': vDesc,
    };
  }

  factory Prod.fromMap(Map<String, dynamic> map) {
    return Prod(
      cProd: map['cProd'],
      xProd: map['xProd'],
      nCM: map['NCM'],
      cFOP: map['CFOP'],
      uCom: map['uCom'],
      qCom: map['qCom'],
      vUnCom: map['vUnCom'],
      vProd: map['vProd'],
      indRegra: map['indRegra'],
      vItem: (map.containsKey('vItem') ? (map['vItem']) : map['vUnCom']) ?? '',
      vDesc: (map.containsKey('vRatDesc') ? (map['vRatDesc']) : map['vRatDesc']) ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Prod.fromJson(String source) => Prod.fromMap(json.decode(source));
}

class Total {
  String? valorTotal;
  String? desconto;
  String? acrescimo;
  Total({this.valorTotal, this.desconto, this.acrescimo});

  Map<String, dynamic> toMap() {
    return {
      'valorTotal': valorTotal,
      'desconto': desconto,
      'acrescimo': acrescimo,
    };
  }

  factory Total.fromMap(Map<String, dynamic> map) {
    return Total(
      valorTotal: (map.containsKey('vCFe') ? map['vCFe'] : map['ICMSTot']['vNF']),
      desconto: (map.containsKey('vCFe') ? (map['DescAcrEntr']?['vDescSubtot']) : map['ICMSTot']['vDesc']),
      acrescimo: (map.containsKey('vCFe') ? null : map['ICMSTot']['vOutro']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Total.fromJson(String source) => Total.fromMap(json.decode(source));
}

class Pgto {
  List<MP>? formas;
  String? vTroco;
  Pgto({this.formas, this.vTroco});

  Map<String, dynamic> toMap() {
    return {
      'MP': formas?.map((x) => x.toMap()).toList(),
      'vTroco': vTroco,
    };
  }

  factory Pgto.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('MP')) {
      final List<MP> _listMP = [];

      if (map['MP'].runtimeType.toString() != 'List<dynamic>') {
        _listMP.add(MP.fromMap(map['MP']));
      } else {
        _listMP.addAll(List<MP>.from(map['MP']?.map((x) => MP.fromMap(x))));
      }
      return Pgto(
        formas: map['MP'] != null ? _listMP : null,
        vTroco: map['vTroco'],
      );
    } else if (map.containsKey('detPag')) {
      final _listMP = [MP.fromMap(map['detPag'])];
      return Pgto(
        formas: map['detPag'] != null ? _listMP : null,
        vTroco: map['vTroco'],
      );
    } else {
      return Pgto();
    }
  }

  String toJson() => json.encode(toMap());

  factory Pgto.fromJson(String source) => Pgto.fromMap(json.decode(source));
}

class DetPag {
  String? tPag;
  String? vPag;
  CardPagamento? card;

  DetPag({this.tPag, this.vPag, this.card});

  Map<String, dynamic> toMap() {
    return {
      'tPag': tPag,
      'vPag': vPag,
      'card': card?.toMap(),
    };
  }

  factory DetPag.fromMap(Map<String, dynamic> map) {
    return DetPag(
      tPag: map['tPag'],
      vPag: map['vPag'],
      card: map['card'] != null ? CardPagamento.fromMap(map['card']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetPag.fromJson(String source) => DetPag.fromMap(json.decode(source));
}

class CardPagamento {
  String? tpIntegra;
  String? cNPJ;
  String? tBand;

  CardPagamento({this.tpIntegra, this.cNPJ, this.tBand});

  Map<String, dynamic> toMap() {
    return {
      'tpIntegra': tpIntegra,
      'cNPJ': cNPJ,
      'tBand': tBand,
    };
  }

  factory CardPagamento.fromMap(Map<String, dynamic> map) {
    return CardPagamento(
      tpIntegra: map['tpIntegra'],
      cNPJ: map['cNPJ'],
      tBand: map['tBand'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CardPagamento.fromJson(String source) => CardPagamento.fromMap(json.decode(source));
}

class MP {
  String? cMP;
  String? vMP;
  MP({this.cMP, this.vMP});

  Map<String, dynamic> toMap() {
    return {
      'cMP': cMP,
      'vMP': vMP,
    };
  }

  factory MP.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> formasPagamento = {
      "10": "Vale Alimentacao",
      "11": "Vale Refeicao",
      "12": "Vale Presente",
      "13": "Vale Combustivel",
      "14": "Duplicata Mercantil",
      "15": "Boleto Bancario",
      "90": "Sem Pagamento",
      "99": "Outros",
      "01": "Dinheiro",
      "02": "Cheque",
      "03": "Cartao de Credito",
      "04": "Cartao de Debito",
      "05": "Credito Loja",
    };
    return MP(
      cMP: (map.containsKey('cMP')) ? formasPagamento[map['cMP']] : formasPagamento[map['tPag']],
      vMP: (map.containsKey('vMP')) ? map['vMP'] : map['vPag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MP.fromJson(String source) => MP.fromMap(json.decode(source));
}

class InfAdic {
  String? infCpl;
  ObsFisco? obsFisco;
  InfAdic({this.infCpl, this.obsFisco});

  Map<String, dynamic> toMap() {
    return {
      'infCpl': infCpl,
      'obsFisco': obsFisco?.toMap(),
    };
  }

  factory InfAdic.fromMap(Map<String, dynamic> map) {
    return InfAdic(
      infCpl: map['infCpl'],
      obsFisco: map['obsFisco'] != null ? ObsFisco.fromMap(map['obsFisco']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfAdic.fromJson(String source) => InfAdic.fromMap(json.decode(source));
}

class ObsFisco {
  String? xTexto;
  String? sXCampo;
  ObsFisco({this.xTexto, this.sXCampo});

  Map<String, dynamic> toMap() {
    return {
      'xTexto': xTexto,
      'sXCampo': sXCampo,
    };
  }

  factory ObsFisco.fromMap(Map<String, dynamic> map) {
    return ObsFisco(
      xTexto: map['xTexto'],
      sXCampo: map['sXCampo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ObsFisco.fromJson(String source) => ObsFisco.fromMap(json.decode(source));
}
