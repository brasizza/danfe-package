import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:example/nfse_controller.dart';
import 'package:flutter/material.dart';

class NfseScreen extends StatefulWidget {
  const NfseScreen({super.key});

  @override
  State<NfseScreen> createState() => _NfseScreenState();
}

class _NfseScreenState extends State<NfseScreen> {
  Nfse? _dadosNfse;
  final NfseController  controller = NfseController();
  final TextEditingController _xmlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _xmlController.text = r'''<?xml version="1.0" encoding="UTF-8"?>
<root>
  <tipoAmbiente>1</tipoAmbiente>
  <versaoAplicativo>SefinNacional_1.5.0</versaoAplicativo>
  <dataHoraProcessamento>2026-01-13T17:15:38.617223-03:00</dataHoraProcessamento>
  <idDps>NFS33045572241593479000102000000000153726017389061468</idDps>
  <chaveAcesso>33045572241593479000102000000000153726017389061468</chaveAcesso>
  <NFSe>
    <infNFSe Id="NFS33045572241593479000102000000000153726017389061468">
      <xLocEmi>Rio de Janeiro</xLocEmi>
      <xLocPrestacao>Rio de Janeiro</xLocPrestacao>
      <nNFSe>1537</nNFSe>
      <cLocIncid>3304557</cLocIncid>
      <DPS xmlns="http://www.sped.fazenda.gov.br/nfse" versao="1.01">
        <infDPS Id="DPS330455724159347900010200002000000000426673">
          <tpAmb>1</tpAmb>
          <dhEmi>2026-01-13T15:17:53-03:00</dhEmi>
          <verAplic>1.10</verAplic>
          <serie>2</serie>
          <nDPS>426673</nDPS>
          <dCompet>2026-01-13</dCompet>
          <tpEmit>1</tpEmit>
          <cLocEmi>3304557</cLocEmi>
          <prest>
            <CNPJ>123444444</CNPJ>
            <regTrib>
              <opSimpNac>1</opSimpNac>
              <regEspTrib>0</regEspTrib>
            </regTrib>
          </prest>
          <serv>
            <locPrest>
              <cLocPrestacao>3304557</cLocPrestacao>
            </locPrest>
            <cServ>
              <cTribNac>171101</cTribNac>
              <cTribMun>001</cTribMun>
              <xDescServ>SERVICOS REFERENTES A CONTA 393707</xDescServ>
              <cNBS>118066300</cNBS>
              <cIntContrib>1</cIntContrib>
            </cServ>
          </serv>
          <valores>
            <vServPrest>
              <vServ>15.90</vServ>
            </vServPrest>
            <trib>
              <tribMun>
                <tribISSQN>1</tribISSQN>
                <tpRetISSQN>1</tpRetISSQN>
              </tribMun>
              <tribFed>
                <piscofins>
                  <CST>00</CST>
                </piscofins>
              </tribFed>
              <totTrib>
                <indTotTrib>0</indTotTrib>
              </totTrib>
            </trib>
          </valores>
        </infDPS>
      </DPS>
    </infNFSe>
  </NFSe>
</root>''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFSe Nacional'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cole o XML da NFSe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _xmlController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Cole aqui o XML da NFSe...',
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _dadosNfse = controller.parseXml(_xmlController.text);
                          });
                        },
                        icon: const Icon(Icons.receipt_long),
                        label: const Text('Processar NFSe'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_dadosNfse != null) ...[
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ações',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showPreviewDialog(context),
                            icon: const Icon(Icons.visibility),
                            label: const Text('Visualizar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showImagePreview(context),
                            icon: const Icon(Icons.image),
                            label: const Text('Preview Imagem'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                          ),

                           ElevatedButton.icon(
                            onPressed: () async {
                              final profile = await CapabilityProfile.load();
                              await controller.printDefault(
                                danfe: _dadosNfse,
                                paper: PaperSize.mm80,
                                profile: profile,
                              );
                            },
                            icon: const Icon(Icons.print),
                            label: const Text('Imprimir'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informações da NFSe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      dadosNfse(_dadosNfse),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPreviewDialog(BuildContext context) {
    // Usa NfsePrinter para gerar o JSON normativo
    final nfsePrinter = NfsePrinter(PaperSize.mm80);
    final jsonNfse = nfsePrinter.normativeJsonNfse(_dadosNfse!);

    final imageDanfe = ImageDanfe(
      jsonData: jsonNfse,
      paperSize: DanfePaperSize.mm80,
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
          child: Column(
            children: [
              AppBar(
                title: const Text('Pré-visualização NFSe'),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.purple,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: imageDanfe.toWidget(margin: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context) async {
    // Usa NfsePrinter para gerar o JSON normativo
    final nfsePrinter = NfsePrinter(PaperSize.mm80);
    final jsonNfse = nfsePrinter.normativeJsonNfse(_dadosNfse!);

    final imageDanfe = ImageDanfe(
      jsonData: jsonNfse,
      paperSize: DanfePaperSize.mm80,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Gerando imagem...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
       final imageBytes = await imageDanfe.toImage(
        context,
        fixedRatio: 2.0,
      );

      final imageParts = await imageDanfe.toEscPosPrinter(
        context,
        maxHeight: 2000,
        maxWidth: 576,
        margin: 0,
        fixedRatio: 1.0,
      );

      if (context.mounted) {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
              child: Column(
                children: [
                  AppBar(
                    title: const Text('Preview - Imagem NFSe'),
                    automaticallyImplyLeading: false,
                    actions: [
                       IconButton(
                        icon: const Icon(Icons.print),
                        onPressed: () async {
                          controller.printImagePos(
                            images: imageParts,
                            paper: PaperSize.mm80,
                            profile: await CapabilityProfile.load(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Função de impressão de imagem'),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Expanded(
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.memory(
                            imageBytes,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar imagem: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget dadosNfse(Nfse? nfse) {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'NFSe Nacional',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Número DPS:', nfse?.infDPS?.nDPS ?? '-'),
            _buildInfoRow('Série:', nfse?.infDPS?.serie ?? '-'),
            _buildInfoRow(
              'Data Emissão:',
              nfse?.infDPS?.dhEmi ?? '-',
            ),
            _buildInfoRow(
              'Data Competência:',
              nfse?.infDPS?.dCompet ?? '-',
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Prestador',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'CNPJ:',
              nfse?.infDPS?.prest?.cnpj ?? '-',
            ),
            _buildInfoRow(
              'Regime Tributário:',
              nfse?.infDPS?.prest?.regTrib?.opSimpNac ?? '-',
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Serviço',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'Código Tributário Nacional:',
              nfse?.infDPS?.serv?.cServ?.cTribNac ?? '-',
            ),
            _buildInfoRow(
              'Código Tributário Municipal:',
              nfse?.infDPS?.serv?.cServ?.cTribMun ?? '-',
            ),
            _buildInfoRow(
              'Código NBS:',
              nfse?.infDPS?.serv?.cServ?.cNBS ?? '-',
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Descrição do Serviço:  ',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    TextSpan(
                      text: nfse?.infDPS?.serv?.cServ?.xDescServ ?? '-',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Valores',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'Valor do Serviço:',
              'R\$ ${nfse?.infDPS?.valores?.vServPrest?.vServ ?? '0.00'}',
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label  ',
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
