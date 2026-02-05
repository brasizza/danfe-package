import 'dart:convert';

import 'emit_nfse.dart';
import 'inf_dps.dart';

/// Classe principal que representa uma NFSe (Nota Fiscal de Serviços Eletrônica) Nacional.
class Nfse {
  /// Informações da DPS (Declaração de Prestação de Serviços).
  InfDPS? infDPS;

  /// Número da NFSe
  String? nNFSe;

  /// Código do local de incidência
  String? cLocIncid;

  /// Descrição do local de incidência
  String? xLocIncid;

  /// Dados do emitente
  EmitNfse? emit;

  /// Versão do aplicativo
  String? verAplic;

  /// Ambiente de geração
  String? ambGer;

  /// Tipo de emissão
  String? tpEmis;

  /// Status da NFSe
  String? cStat;

  /// Data e hora de processamento
  String? dhProc;

  /// Construtor da classe Nfse.
  Nfse({
    this.infDPS,
    this.nNFSe,
    this.cLocIncid,
    this.xLocIncid,
    this.emit,
    this.verAplic,
    this.ambGer,
    this.tpEmis,
    this.cStat,
    this.dhProc,
  });

  /// Cria uma instância de Nfse a partir de um Map.
  factory Nfse.fromMap(Map<String, dynamic> map) {
    return Nfse(
      infDPS: map['infDPS'] != null ? InfDPS.fromMap(map['infDPS'], map['valores']) : null,
      nNFSe: map['nNFSe']?.toString(),
      cLocIncid: map['cLocIncid']?.toString(),
      xLocIncid: map['xLocIncid']?.toString(),
      emit: map['emit'] != null ? EmitNfse.fromMap(map['emit']) : null,
      verAplic: map['verAplic']?.toString(),
      ambGer: map['ambGer']?.toString(),
      tpEmis: map['tpEmis']?.toString(),
      cStat: map['cStat']?.toString(),
      dhProc: map['dhProc']?.toString(),
    );
  }

  /// Converte a instância em um Map.
  Map<String, dynamic> toMap() {
    return {
      if (infDPS != null) 'infDPS': infDPS?.toMap(),
      if (nNFSe != null) 'nNFSe': nNFSe,
      if (cLocIncid != null) 'cLocIncid': cLocIncid,
      if (xLocIncid != null) 'xLocIncid': xLocIncid,
      if (emit != null) 'emit': emit?.toMap(),
      if (verAplic != null) 'verAplic': verAplic,
      if (ambGer != null) 'ambGer': ambGer,
      if (tpEmis != null) 'tpEmis': tpEmis,
      if (cStat != null) 'cStat': cStat,
      if (dhProc != null) 'dhProc': dhProc,
    };
  }

  /// Converte a instância em JSON.
  String toJson() => json.encode(toMap());
}
