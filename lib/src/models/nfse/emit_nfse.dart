import 'dart:convert';

/// Classe que representa os dados do Emitente na NFSe Nacional.
class EmitNfse {
  /// CNPJ do emitente
  final String? cnpj;

  /// Nome/Razão Social do emitente
  final String? xNome;

  /// Endereço do emitente
  final EnderecoEmitNfse? enderNac;

  /// Telefone do emitente
  final String? fone;

  /// Email do emitente
  final String? email;

  EmitNfse({
    this.cnpj,
    this.xNome,
    this.enderNac,
    this.fone,
    this.email,
  });

  factory EmitNfse.fromMap(Map<String, dynamic> map) {
    return EmitNfse(
      cnpj: map['CNPJ']?.toString(),
      xNome: map['xNome']?.toString(),
      enderNac: map['enderNac'] != null
          ? EnderecoEmitNfse.fromMap(
              map['enderNac'] is Map ? map['enderNac'] : {},
            )
          : null,
      fone: map['fone']?.toString(),
      email: map['email']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (cnpj != null) 'CNPJ': cnpj,
      if (xNome != null) 'xNome': xNome,
      if (enderNac != null) 'enderNac': enderNac!.toMap(),
      if (fone != null) 'fone': fone,
      if (email != null) 'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  factory EmitNfse.fromJson(String source) =>
      EmitNfse.fromMap(json.decode(source));
}

/// Classe que representa o Endereço do Emitente na NFSe Nacional.
class EnderecoEmitNfse {
  /// Logradouro
  final String? xLgr;

  /// Número
  final String? nro;

  /// Complemento
  final String? xCpl;

  /// Bairro
  final String? xBairro;

  /// Código do município
  final String? cMun;

  /// UF
  final String? uf;

  /// CEP
  final String? cep;

  EnderecoEmitNfse({
    this.xLgr,
    this.nro,
    this.xCpl,
    this.xBairro,
    this.cMun,
    this.uf,
    this.cep,
  });

  factory EnderecoEmitNfse.fromMap(Map<String, dynamic> map) {
    return EnderecoEmitNfse(
      xLgr: map['xLgr']?.toString(),
      nro: map['nro']?.toString(),
      xCpl: map['xCpl']?.toString(),
      xBairro: map['xBairro']?.toString(),
      cMun: map['cMun']?.toString(),
      uf: map['UF']?.toString(),
      cep: map['CEP']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (xLgr != null) 'xLgr': xLgr,
      if (nro != null) 'nro': nro,
      if (xCpl != null) 'xCpl': xCpl,
      if (xBairro != null) 'xBairro': xBairro,
      if (cMun != null) 'cMun': cMun,
      if (uf != null) 'UF': uf,
      if (cep != null) 'CEP': cep,
    };
  }

  String toJson() => json.encode(toMap());

  factory EnderecoEmitNfse.fromJson(String source) =>
      EnderecoEmitNfse.fromMap(json.decode(source));
}
