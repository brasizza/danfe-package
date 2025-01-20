import 'dart:convert';

import 'package:danfe/src/models/cobr.dart';
import 'package:danfe/src/models/transp.dart';

import 'dest.dart';
import 'det.dart';
import 'emit.dart';
import 'ide.dart';
import 'inf_adic.dart';
import 'pgto.dart';
import 'total.dart';

/// A classe `DadosDanfe` representa os dados estruturados de um DANFE (Documento Auxiliar da Nota Fiscal Eletrônica).
///
/// ### Responsabilidades:
/// - Agrupar informações sobre a identificação da nota, emitente, destinatário, itens, totais, pagamentos e outros.
/// - Suportar conversões para e de `Map<String, dynamic>` e JSON.
///
/// Essa classe centraliza todos os dados essenciais para a manipulação e formatação de um DANFE.
class DadosDanfe {
  /// Identificação da nota fiscal.
  /// Instância da classe [Ide], que contém informações como UF, número de série, e data de emissão.
  Ide? ide;

  /// Dados do emitente da nota.
  /// Instância da classe [Emit], que contém informações como CNPJ, nome e endereço do emitente.
  Emit? emit;

  /// Dados do destinatário da nota.
  /// Instância da classe [Dest], que contém informações como CPF/CNPJ e nome do destinatário.
  Dest? dest;

  /// Lista de itens (detalhes) presentes na nota.
  /// Cada item é representado por uma instância da classe [Det], que inclui detalhes como descrição e valores dos produtos.
  List<Det>? det;

  /// Totais calculados da nota fiscal.
  /// Representados por uma instância da classe [Total], que inclui informações como valor total e descontos.
  Total? total;

  /// Informações sobre o transporte de itens
  /// Instância da classe [Transp], que detalha as formas de transporte.
  Transp? transp;

  /// Informações sobre cobranca.
  /// Instância da classe [Cobr], que detalha a cobranca da Nota fiscal.
  Cobr? cobr;

  /// Informações sobre os pagamentos realizados.
  /// Instância da classe [Pgto], que detalha as formas de pagamento e valores envolvidos.
  Pgto? pgto;

  /// Informações adicionais presentes no DANFE.
  /// Instância da classe [InfAdic], contendo observações fiscais e complementares.
  InfAdic? infAdic;

  /// Chave de acesso da nota fiscal.
  String? chaveNota;

  /// Versão do layout do documento.
  String? sVersao;

  /// Versão dos dados de entrada.
  String? sVersaoDadosEnt;

  /// Versão do software básico utilizado.
  String? sVersaoSB;

  /// Construtor da classe `DadosDanfe`.
  ///
  /// ### Parâmetros:
  /// - [ide]: Informações de identificação da nota.
  /// - [emit]: Informações do emitente.
  /// - [dest]: Informações do destinatário.
  /// - [det]: Lista de itens (detalhes) da nota.
  /// - [total]: Informações dos totais da nota.
  /// - [pgto]: Informações sobre os pagamentos.
  /// - [infAdic]: Informações adicionais.
  /// - [chaveNota]: Chave de acesso da nota fiscal.
  /// - [sVersao]: Versão do layout.
  /// - [sVersaoDadosEnt]: Versão dos dados de entrada.
  /// - [sVersaoSB]: Versão do software básico.
  DadosDanfe({
    this.ide,
    this.emit,
    this.dest,
    this.det,
    this.total,
    this.pgto,
    this.infAdic,
    this.chaveNota,
    this.sVersao,
    this.sVersaoDadosEnt,
    this.sVersaoSB,
    this.transp,
    this.cobr,
  });

  /// Converte a instância atual em um mapa (`Map<String, dynamic>`).
  ///
  /// ### Retorno:
  /// - Um mapa com as propriedades da classe e seus respectivos valores.
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
      'transp': transp?.toMap(),
      'cobr': cobr?.toMap(),
    };
  }

  /// Cria uma instância de `DadosDanfe` a partir de um mapa (`Map<String, dynamic>`).
  ///
  /// ### Parâmetros:
  /// - [map]: Um mapa contendo as chaves e valores correspondentes às propriedades da classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `DadosDanfe` populada com os valores fornecidos no mapa.
  factory DadosDanfe.fromMap(Map<String, dynamic> map) {
    final List<Det> det = (map['det'] is List)
        ? List<Det>.from(map['det'].map((x) => Det.fromMap(x)))
        : [Det.fromMap(map['det'])];

    return DadosDanfe(
      ide: map['ide'] != null ? Ide.fromMap(map['ide']) : null,
      emit: map['emit'] != null ? Emit.fromMap(map['emit']) : null,
      dest: (map['dest'] != null && map['dest'] != '')
          ? Dest.fromMap(map['dest'])
          : null,
      det: map['det'] != null ? det : null,
      total: map['total'] != null ? Total.fromMap(map['total']) : null,
      transp: map['transp'] != null ? Transp.fromMap(map['transp']) : null,
      pgto: (map['pgto'] ?? map['pag']) != null
          ? Pgto.fromMap(map['pgto'] ?? map['pag'])
          : null,
      infAdic: map['infAdic'] != null ? InfAdic.fromMap(map['infAdic']) : null,
      chaveNota:
          (map['_Id'] as String).replaceAll('CFe', '').replaceAll('NFe', ''),
      sVersao: map['_versao'],
      sVersaoDadosEnt: map['_versaoDadosEnt'],
      sVersaoSB: map['_versaoSB'],
      cobr: map['cobr'] != null ? Cobr.fromMap(map['cobr']) : null,
    );
  }

  /// Converte a instância atual em uma string JSON.
  ///
  /// ### Retorno:
  /// - Uma string JSON representando os dados da instância.
  String toJson() => json.encode(toMap());

  /// Cria uma instância de `DadosDanfe` a partir de uma string JSON.
  ///
  /// ### Parâmetros:
  /// - [source]: Uma string JSON contendo os dados para a classe.
  ///
  /// ### Retorno:
  /// - Uma instância de `DadosDanfe` populada com os valores fornecidos no JSON.
  factory DadosDanfe.fromJson(String source) =>
      DadosDanfe.fromMap(json.decode(source));
}
