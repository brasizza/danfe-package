import 'dart:convert';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

import 'danfe.dart';

class NfsePrinter {
  /// Define o tamanho do papel utilizado para a impressão (58mm ou 80mm).
  final PaperSize paperSize;

  /// Construtor da classe NfsePrinter.
  ///
  /// Recebe o tamanho do papel como parâmetro para configuração da impressão.
  NfsePrinter(this.paperSize);

  /// Gera o buffer de dados para impressão da NFSe em formato ESC/POS.
  ///
  /// [nfse] - Dados da NFSe que serão processados para impressão.
  /// [mostrarMoeda] - Define se o símbolo da moeda deve ser exibido. Valor padrão é `true`.
  ///
  /// Retorna uma lista de bytes que representa os comandos de impressão.
  Future<List<int>> bufferNfse(
    Nfse? nfse, {
    bool mostrarMoeda = true,
  }) async {
    String moeda = (mostrarMoeda == true) ? r'R$' : '';
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];

    // Cabeçalho - Dados do Emitente
    bytes += generator.rawBytes([27, 97, 49]); // Centralizado
    if (nfse?.emit != null) {
      bytes += generator.text(
        DanfeUtils.removeAcentos(nfse!.emit!.xNome ?? ''),
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );

      bytes += generator.text(
        'CNPJ - ${DanfeUtils.formatCNPJ(nfse.emit!.cnpj ?? '')}',
        styles: const PosStyles(align: PosAlign.center),
      );

      if (nfse.emit!.enderNac != null) {
        final endereco = nfse.emit!.enderNac!;
        final String uf = endereco.uf == null ? '' : ' - ${endereco.uf}';

        bytes += generator.text(
          DanfeUtils.removeAcentos(
            '${endereco.xLgr ?? ''},${endereco.nro ?? ''} ${endereco.xBairro ?? ''}$uf',
          ),
          styles: const PosStyles(align: PosAlign.center),
        );

        if (endereco.cep != null) {
          bytes += generator.text(
            'CEP: ${DanfeUtils.formatCep(endereco.cep ?? '')}',
            styles: const PosStyles(align: PosAlign.center),
          );
        }
      }

      if (nfse.emit!.fone != null) {
        bytes += generator.text(
          'Fone: ${nfse.emit!.fone}',
          styles: const PosStyles(align: PosAlign.center),
        );
      }

      if (nfse.emit!.email != null) {
        bytes += generator.text(
          'Email: ${nfse.emit!.email}',
          styles: const PosStyles(align: PosAlign.center),
        );
      }
    }

    bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda
    bytes += generator.hr();
    bytes += generator.rawBytes([27, 97, 49]); // Centralizado

    // Título do documento
    bytes += generator.text(
      'NFSe - Nota Fiscal de Servico Eletronica',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ),
    );

    bytes += generator.text(
      'NACIONAL',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda
    bytes += generator.hr();

    // Número da NFSe
    if (nfse?.nNFSe != null) {
      bytes += generator.text(
        'Numero NFSe: ${nfse!.nNFSe}',
        styles: const PosStyles(align: PosAlign.left, bold: true),
      );
    }

    // Data e hora de processamento
    if (nfse?.dhProc != null) {
      bytes += generator.text(
        'Data Processamento: ${DanfeUtils.formatDate(nfse!.dhProc!, dateOnly: false)}',
        styles: const PosStyles(align: PosAlign.left),
      );
    }

    // Ambiente de geração
    if (nfse?.ambGer != null) {
      final ambiente = nfse!.ambGer == '1' ? 'Producao' : 'Homologacao';
      bytes += generator.text(
        'Ambiente: $ambiente',
        styles: const PosStyles(align: PosAlign.left),
      );
    }

    // Status
    if (nfse?.cStat != null && nfse?.xLocIncid != null) {
      bytes += generator.text(
        'Status: ${nfse!.cStat} - ${DanfeUtils.removeAcentos(nfse.xLocIncid!)}',
        styles: const PosStyles(align: PosAlign.left),
      );
    }

    bytes += generator.hr();

    // Dados do Prestador
    if (nfse?.infDPS?.prest != null) {
      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'DADOS DO PRESTADOR',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda

      final prestador = nfse!.infDPS!.prest!;

      bytes += generator.text(
        'CNPJ: ${DanfeUtils.formatCNPJ(prestador.cnpj ?? '')}',
        styles: const PosStyles(align: PosAlign.left),
      );

      bytes += generator.hr();
    }

    // Dados do Tomador
    if (nfse?.infDPS?.tomador != null) {
      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'DADOS DO TOMADOR',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda

      final tomador = nfse!.infDPS!.tomador!;

      if (tomador.cnpj != null) {
        bytes += generator.text(
          'CNPJ: ${DanfeUtils.formatCNPJ(tomador.cnpj!)}',
          styles: const PosStyles(align: PosAlign.left),
        );
      } else if (tomador.cpf != null) {
        bytes += generator.text(
          'CPF: ${DanfeUtils.formatCPF(tomador.cpf!)}',
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      if (tomador.xNome != null) {
        bytes += generator.text(
          DanfeUtils.removeAcentos('Nome: ${tomador.xNome}'),
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      if (tomador.endereco != null) {
        final endereco = tomador.endereco!;
        bytes += generator.text(
          DanfeUtils.removeAcentos(
            'Endereco: ${endereco.xLgr ?? ''}, ${endereco.nro ?? ''}',
          ),
          styles: const PosStyles(align: PosAlign.left),
        );

        if (endereco.xBairro != null) {
          bytes += generator.text(
            DanfeUtils.removeAcentos('Bairro: ${endereco.xBairro}'),
            styles: const PosStyles(align: PosAlign.left),
          );
        }

        if (endereco.cMun != null && endereco.uf != null) {
          bytes += generator.text(
            '${endereco.cMun} - ${endereco.uf}',
            styles: const PosStyles(align: PosAlign.left),
          );
        }

        if (endereco.cep != null) {
          bytes += generator.text(
            'CEP: ${DanfeUtils.formatCep(endereco.cep!)}',
            styles: const PosStyles(align: PosAlign.left),
          );
        }
      }

      bytes += generator.hr();
    }

    // Dados do Serviço
    if (nfse?.infDPS?.serv?.cServ != null) {
      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'DADOS DO SERVICO',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda

      final cServ = nfse!.infDPS!.serv!.cServ!;

      if (cServ.xDescServ != null) {
        bytes += generator.text(
          DanfeUtils.removeAcentos('Descricao: ${cServ.xDescServ}'),
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      if (cServ.cTribNac != null) {
        bytes += generator.text(
          'Codigo Trib. Nacional: ${cServ.cTribNac}',
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      if (cServ.cTribMun != null) {
        bytes += generator.text(
          'Codigo Trib. Municipal: ${cServ.cTribMun}',
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      if (cServ.cNBS != null) {
        bytes += generator.text(
          'CNBS: ${cServ.cNBS}',
          styles: const PosStyles(align: PosAlign.left),
        );
      }

      bytes += generator.hr();
    }

    // Valores
    if (nfse?.infDPS?.valores?.vServPrest != null) {
      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'VALORES',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda

      final vServPrest = nfse!.infDPS!.valores!.vServPrest!;

      if (vServPrest.vServ != null) {
        bytes += generator.row([
          PosColumn(
            text: 'Valor Servicos:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              vServPrest.vServ!,
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      if (vServPrest.vDed != null && vServPrest.vDed != '0.00') {
        bytes += generator.row([
          PosColumn(
            text: 'Deducoes:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              vServPrest.vDed!,
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      if (vServPrest.vBC != null) {
        bytes += generator.row([
          PosColumn(
            text: 'Base Calculo:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left, bold: true),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              vServPrest.vBC!,
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 6,
            styles: const PosStyles(align: PosAlign.right, bold: true),
          ),
        ]);
      }

      bytes += generator.hr();
    }

    // Tributos
    if (nfse?.infDPS?.valores?.trib?.totTrib != null) {
      final totTrib = nfse!.infDPS?.valores?.trib?.totTrib;
      final tribMun = nfse.infDPS?.valores?.trib?.tribMun;

      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'TRIBUTOS',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      );
      bytes += generator.rawBytes([27, 97, 48]); // Alinhamento à esquerda

      if (tribMun?.pAliq != null) {
        bytes += generator.row([
          PosColumn(
            text: 'Percentual da aliquota:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text:
                '${DanfeUtils.formatMoneyMilhar(
                  tribMun!.pAliq!,
                  modeda: 'pt_BR',
                  simbolo: '',
                )}%',
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      if (totTrib?.vTotTrib != null) {
        bytes += generator.row([
          PosColumn(
            text: 'Total Tributos:',
            width: 6,
            styles: const PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: DanfeUtils.formatMoneyMilhar(
              totTrib!.vTotTrib!,
              modeda: 'pt_BR',
              simbolo: moeda,
            ),
            width: 6,
            styles: const PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.hr();
    }

    // Rodapé com informações adicionais
    if (nfse?.verAplic != null) {
      bytes += generator.rawBytes([27, 97, 49]); // Centralizado
      bytes += generator.text(
        'Versao: ${nfse!.verAplic}',
        styles: const PosStyles(align: PosAlign.center),
      );
    }

    bytes += generator.feed(1);
    bytes += generator.cut();
    bytes += generator.reset();

    return bytes;
  }

  /// Gera o JSON normativo para impressão da NFSe.
  ///
  /// [nfse] - Dados da NFSe que serão processados.
  /// [mostrarMoeda] - Define se o símbolo da moeda deve ser exibido. Valor padrão é `true`.
  ///
  /// Retorna uma string JSON compatível com printer_gateway.
  String normativeJsonNfse(Nfse? nfse, {bool mostrarMoeda = true}) {
    String moeda = (mostrarMoeda == true) ? 'R\$' : '';
    final helper = JsonPrinterHelper();

    List<Map> nfseJson = [];

    // Cabeçalho - Dados do Prestador (Emitente)
    if (nfse?.emit != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: true,
          fontSize: 18,
          italic: false,
          content: DanfeUtils.removeAcentos(nfse!.emit!.xNome ?? ''),
        ),
      );

      nfseJson.add(
        helper.prepareLine(
          aligment: 1,
          bold: false,
          fontSize: 12,
          italic: false,
          content: 'CNPJ - ${DanfeUtils.formatCNPJ(nfse.emit!.cnpj ?? '')}',
        ),
      );

      if (nfse.emit!.enderNac != null) {
        final endereco = nfse.emit!.enderNac!;
        final String uf = endereco.uf == null ? '' : ' - ${endereco.uf}';

        nfseJson.add(
          helper.prepareLine(
            aligment: 1,
            bold: false,
            fontSize: 12,
            italic: false,
            content: DanfeUtils.removeAcentos(
              '${endereco.xLgr ?? ''},${endereco.nro ?? ''} ${endereco.xBairro ?? ''}$uf',
            ),
          ),
        );

        if (endereco.cep != null) {
          nfseJson.add(
            helper.prepareLine(
              aligment: 1,
              bold: false,
              fontSize: 12,
              italic: false,
              content: 'CEP: ${DanfeUtils.formatCep(endereco.cep ?? '')}',
            ),
          );
        }
      }

      if (nfse.emit!.fone != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 1,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'Fone: ${nfse.emit!.fone}',
          ),
        );
      }

      if (nfse.emit!.email != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 1,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'Email: ${nfse.emit!.email}',
          ),
        );
      }
    }

    nfseJson.add(helper.divider());

    // Título do documento
    nfseJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: true,
        fontSize: 14,
        italic: false,
        content: 'NFSe - Nota Fiscal de Servico Eletronica',
      ),
    );

    nfseJson.add(
      helper.prepareLine(
        aligment: 1,
        bold: false,
        fontSize: 12,
        italic: false,
        content: 'NACIONAL',
      ),
    );

    nfseJson.add(helper.divider());

    // Número da NFSe
    if (nfse?.nNFSe != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'Numero NFSe: ${nfse!.nNFSe}',
        ),
      );
    }

    // Data e hora de processamento
    if (nfse?.dhProc != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 12,
          italic: false,
          content:
              'Data Processamento: ${DanfeUtils.formatDate(nfse!.dhProc!, dateOnly: false)}',
        ),
      );
    }

    // Ambiente de geração
    if (nfse?.ambGer != null) {
      final ambiente = nfse!.ambGer == '1' ? 'Producao' : 'Homologacao';
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 12,
          italic: false,
          content: 'Ambiente: $ambiente',
        ),
      );
    }

    // Status
    if (nfse?.cStat != null && nfse?.xLocIncid != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 12,
          italic: false,
          content: 'Status: ${nfse!.cStat} - ${nfse.xLocIncid}',
        ),
      );
    }

    nfseJson.add(helper.divider());

    // Dados do Prestador
    if (nfse?.infDPS?.prest != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'DADOS DO PRESTADOR',
        ),
      );

      final prestador = nfse!.infDPS!.prest!;

      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: false,
          fontSize: 12,
          italic: false,
          content: 'CNPJ: ${DanfeUtils.formatCNPJ(prestador.cnpj ?? '')}',
        ),
      );

      nfseJson.add(helper.divider());
    }

    // Dados do Tomador
    if (nfse?.infDPS?.tomador != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'DADOS DO TOMADOR',
        ),
      );

      final tomador = nfse!.infDPS!.tomador!;

      if (tomador.cnpj != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'CNPJ: ${DanfeUtils.formatCNPJ(tomador.cnpj!)}',
          ),
        );
      } else if (tomador.cpf != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'CPF: ${DanfeUtils.formatCPF(tomador.cpf!)}',
          ),
        );
      }

      if (tomador.xNome != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: DanfeUtils.removeAcentos('Nome: ${tomador.xNome}'),
          ),
        );
      }

      if (tomador.endereco != null) {
        final endereco = tomador.endereco!;
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: DanfeUtils.removeAcentos(
              'Endereco: ${endereco.xLgr ?? ''}, ${endereco.nro ?? ''} ${endereco.xCpl ?? ''} ${endereco.xBairro ?? ''} - ${endereco.cMun ?? ''} ${endereco.uf ?? ''}',
            ),
          ),
        );

        if (endereco.cep != null) {
          nfseJson.add(
            helper.prepareLine(
              aligment: 0,
              bold: false,
              fontSize: 12,
              italic: false,
              content: 'CEP: ${DanfeUtils.formatCep(endereco.cep!)}',
            ),
          );
        }
      }

      nfseJson.add(helper.divider());
    }

    // Dados do Serviço
    if (nfse?.infDPS?.serv?.cServ != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'DADOS DO SERVICO',
        ),
      );

      final cServ = nfse!.infDPS!.serv!.cServ!;

      if (cServ.xDescServ != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: DanfeUtils.removeAcentos('Descricao: ${cServ.xDescServ}'),
          ),
        );
      }

      if (cServ.cTribNac != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'Codigo Trib. Nacional: ${cServ.cTribNac}',
          ),
        );
      }

      if (cServ.cTribMun != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'Codigo Trib. Municipal: ${cServ.cTribMun}',
          ),
        );
      }

      if (cServ.cNBS != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content: 'CNBS: ${cServ.cNBS}',
          ),
        );
      }

      nfseJson.add(helper.divider());
    }

    // Valores
    if (nfse?.infDPS?.valores?.vServPrest != null) {
      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'VALORES',
        ),
      );

      final vServPrest = nfse!.infDPS!.valores!.vServPrest!;

      if (vServPrest.vServ != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content:
                'Valor Servicos: ${DanfeUtils.formatMoneyMilhar(vServPrest.vServ!, modeda: 'pt_BR', simbolo: moeda)}',
          ),
        );
      }

      if (vServPrest.vDed != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content:
                'Deducoes: ${DanfeUtils.formatMoneyMilhar(vServPrest.vDed!, modeda: 'pt_BR', simbolo: moeda)}',
          ),
        );
      }

      if (vServPrest.vBC != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: true,
            fontSize: 12,
            italic: false,
            content:
                'Base Calculo: ${DanfeUtils.formatMoneyMilhar(vServPrest.vBC!, modeda: 'pt_BR', simbolo: moeda)}',
          ),
        );
      }

      nfseJson.add(helper.divider());
    }

    // Tributos
    if (nfse?.infDPS?.valores?.trib != null) {
      final trib = nfse!.infDPS!.valores!.trib!;

      nfseJson.add(
        helper.prepareLine(
          aligment: 0,
          bold: true,
          fontSize: 12,
          italic: false,
          content: 'TRIBUTOS',
        ),
      );

      if (trib.tribMun?.pAliq != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content:
                'Percentual da alíquota: ${DanfeUtils.formatMoneyMilhar(trib.tribMun!.pAliq!, modeda: 'pt_BR', simbolo: '')}%',
          ),
        );
      }

      if (trib.totTrib?.vTotTrib != null) {
        nfseJson.add(
          helper.prepareLine(
            aligment: 0,
            bold: false,
            fontSize: 12,
            italic: false,
            content:
                'Total Tributos: ${DanfeUtils.formatMoneyMilhar(trib.totTrib!.vTotTrib!, modeda: 'pt_BR', simbolo: moeda)}',
          ),
        );
      }
      nfseJson.add(helper.divider());
    }

    return json.encode(nfseJson);
  }
}
