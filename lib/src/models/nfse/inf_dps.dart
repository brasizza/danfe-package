import 'prestador.dart';
import 'servico.dart';
import 'tomador.dart';
import 'valores.dart';

/// Informações da DPS (Declaração de Prestação de Serviços).
class InfDPS {
  /// ID da DPS.
  String? id;

  /// Tipo de ambiente (1-Produção, 2-Homologação).
  String? tpAmb;

  /// Data e hora de emissão.
  String? dhEmi;

  /// Versão da aplicação.
  String? verAplic;

  /// Série da DPS.
  String? serie;

  /// Número da DPS.
  String? nDPS;

  /// Data de competência.
  String? dCompet;

  /// Tipo de emitente.
  String? tpEmit;

  /// Código do local de emissão.
  String? cLocEmi;

  /// Dados do prestador.
  Prestador? prest;

  /// Dados do tomador (opcional).
  Tomador? tomador;

  /// Dados do serviço.
  Servico? serv;

  /// Valores da NFSe.
  Valores? valores;

  /// Construtor.
  InfDPS({
    this.id,
    this.tpAmb,
    this.dhEmi,
    this.verAplic,
    this.serie,
    this.nDPS,
    this.dCompet,
    this.tpEmit,
    this.cLocEmi,
    this.prest,
    this.tomador,
    this.serv,
    this.valores,
  });

  /// Cria uma instância a partir de um Map.
  factory InfDPS.fromMap(
    Map<String, dynamic> map,
    Map<String, dynamic>? valoresMap,
  ) {
    final merged = <String, dynamic>{
      if (map['valores'] is Map<String, dynamic>)
        ...map['valores'] as Map<String, dynamic>,
      ...valoresMap ?? {},
    };
    return InfDPS(
      id: map['@Id'] ?? map['Id'],
      tpAmb: map['tpAmb'],
      dhEmi: map['dhEmi'],
      verAplic: map['verAplic'],
      serie: map['serie'],
      nDPS: map['nDPS'],
      dCompet: map['dCompet'],
      tpEmit: map['tpEmit'],
      cLocEmi: map['cLocEmi'],
      prest: map['prest'] != null ? Prestador.fromMap(map['prest']) : null,
      tomador: map['tomador'] != null ? Tomador.fromMap(map['tomador']) : null,
      serv: map['serv'] != null ? Servico.fromMap(map['serv']) : null,
      valores: map['valores'] != null ? Valores.fromMap(merged) : null,
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tpAmb': tpAmb,
      'dhEmi': dhEmi,
      'verAplic': verAplic,
      'serie': serie,
      'nDPS': nDPS,
      'dCompet': dCompet,
      'tpEmit': tpEmit,
      'cLocEmi': cLocEmi,
      'prest': prest?.toMap(),
      'tomador': tomador?.toMap(),
      'serv': serv?.toMap(),
      'valores': valores?.toMap(),
    };
  }
}
