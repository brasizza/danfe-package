/// Dados do tomador de serviços.
class Tomador {
  /// CNPJ do tomador.
  String? cnpj;

  /// CPF do tomador.
  String? cpf;

  /// Razão social ou nome.
  String? xNome;

  /// Endereço do tomador.
  EnderecoTomador? endereco;

  /// Construtor.
  Tomador({this.cnpj, this.cpf, this.xNome, this.endereco});

  /// Cria uma instância a partir de um Map.
  factory Tomador.fromMap(Map<String, dynamic> map) {
    return Tomador(
      cnpj: map['CNPJ'],
      cpf: map['CPF'],
      xNome: map['xNome'],
      endereco: map['endereco'] != null
          ? EnderecoTomador.fromMap(map['endereco'])
          : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'CNPJ': cnpj,
      'CPF': cpf,
      'xNome': xNome,
      'endereco': endereco?.toMap(),
    };
  }
}

/// Endereço do tomador.
class EnderecoTomador {
  /// Logradouro.
  String? xLgr;

  /// Número.
  String? nro;

  /// Complemento.
  String? xCpl;

  /// Bairro.
  String? xBairro;

  /// Código do município.
  String? cMun;

  /// Nome do município.
  String? xMun;

  /// UF.
  String? uf;

  /// CEP.
  String? cep;

  /// Construtor.
  EnderecoTomador({
    this.xLgr,
    this.nro,
    this.xCpl,
    this.xBairro,
    this.cMun,
    this.xMun,
    this.uf,
    this.cep,
  });

  /// Cria uma instância a partir de um Map.
  factory EnderecoTomador.fromMap(Map<String, dynamic> map) {
    return EnderecoTomador(
      xLgr: map['xLgr'],
      nro: map['nro'],
      xCpl: map['xCpl'],
      xBairro: map['xBairro'],
      cMun: map['cMun'],
      xMun: map['xMun'],
      uf: map['UF'] ?? map['uf'],
      cep: map['CEP'] ?? map['cep'],
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'xLgr': xLgr,
      'nro': nro,
      'xCpl': xCpl,
      'xBairro': xBairro,
      'cMun': cMun,
      'xMun': xMun,
      'uf': uf,
      'cep': cep,
    };
  }
}
