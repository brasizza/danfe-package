import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/material.dart';
import '../danfe_controller.dart';

class DanfeScreen extends StatefulWidget {
  const DanfeScreen({super.key});

  @override
  State<DanfeScreen> createState() => _DanfeScreenState();
}

class _DanfeScreenState extends State<DanfeScreen> {
  final controller = DanfeController();
  Danfe? _dadosDanfe;
  final TextEditingController _xmlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _xmlController.text = r'''<?xml version="1.0"?>
<CFe>
  <infCFe Id="CFe35161261099008000141599000026310003024947916" versao="0.07" versaoDadosEnt="0.07" versaoSB="010300">
    <ide>
      <cUF>35</cUF>
      <cNF>494791</cNF>
      <mod>59</mod>
      <nserieSAT>900002631</nserieSAT>
      <nCFe>000302</nCFe>
      <dEmi>20161220</dEmi>
      <hEmi>095111</hEmi>
      <cDV>6</cDV>
      <tpAmb>2</tpAmb>
      <CNPJ>08427847000169</CNPJ>
      <signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC>
      <assinaturaQRCODE>EKP6q5FOMSxPfTr4yf2LHBw4UTp6vsFsJ6cM3c6Lc0AjLExZ63tERLucVgp5Ao69fzmS103/PiTyw2XdweVebq1hfLiK7vbPRqgVWJySxjcLUCzMJacVlPCJyOwTxDL34tyvbW6Vr+c2+jBB3HsqO3zxW9ZsrzBWhhkxx9zWgFC6CSf5wOZe88+cTU+JVpWN6pPUEKIoeO3Z0/1+WZz1ESoU+kGfpVu+z45j70AZu0bIRjFT6bqs65BUDtUKRtMsq72vocnSD9yQgYHwNpZglCGkREyF2qQu18oqN0RQvi9L8DBSFhxf8QW2RC13XpqfmLWwFXc8sjp1VjjgDH6CYQ==</assinaturaQRCODE>
      <numeroCaixa>001</numeroCaixa>
    </ide>
    <emit>
      <CNPJ>61099008000141</CNPJ>
      <xNome>DIMAS DE MELO PIMENTA SISTEMAS DE PONTO E ACESSO LTDA</xNome>
      <xFant>DIMEP</xFant>
      <enderEmit>
        <xLgr>AVENIDA MOFARREJ</xLgr>
        <nro>840</nro>
        <xCpl>908</xCpl>
        <xBairro>VL. LEOPOLDINA</xBairro>
        <xMun>SAO PAULO</xMun>
        <CEP>05311000</CEP>
      </enderEmit>
      <IE>111111111111</IE>
      <IM>12345</IM>
      <cRegTrib>3</cRegTrib>
      <cRegTribISSQN>3</cRegTribISSQN>
      <indRatISSQN>N</indRatISSQN>
    </emit>
    <dest/>
    <det nItem="1">
      <prod>
        <cProd>116</cProd>
        <cEAN>9990000001163</cEAN>
        <xProd>Cascao</xProd>
        <CFOP>5405</CFOP>
        <uCom>UN</uCom>
        <qCom>1.0000</qCom>
        <vUnCom>4.00</vUnCom>
        <vProd>4.00</vProd>
        <indRegra>A</indRegra>
        <vItem>4.00</vItem>
      </prod>
      <imposto>
        <ICMS>
          <ICMSSN102>
            <Orig>0</Orig>
            <CSOSN>500</CSOSN>
          </ICMSSN102>
        </ICMS>
        <PIS>
          <PISSN>
            <CST>49</CST>
          </PISSN>
        </PIS>
        <COFINS>
          <COFINSSN>
            <CST>49</CST>
          </COFINSSN>
        </COFINS>
      </imposto>
    </det>
    <total>
      <ICMSTot>
        <vICMS>0.00</vICMS>
        <vProd>4.00</vProd>
        <vDesc>0.00</vDesc>
        <vPIS>0.00</vPIS>
        <vCOFINS>0.00</vCOFINS>
        <vPISST>0.00</vPISST>
        <vCOFINSST>0.00</vCOFINSST>
        <vOutro>0.00</vOutro>
      </ICMSTot>
      <vCFe>4.00</vCFe>
    </total>
    <pgto>
      <MP>
        <cMP>01</cMP>
        <vMP>4.00</vMP>
      </MP>
      <vTroco>0.00</vTroco>
    </pgto>
  </infCFe>
  <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
    <SignedInfo>
      <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
      <SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
      <Reference URI="#CFe35161261099008000141599000026310003024947916">
        <Transforms>
          <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
          <Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
        </Transforms>
        <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
        <DigestValue>3sW0ay6BB4wbJUVnp9B1SQpqCka+ga8gwxHy/ViCXuw=</DigestValue>
      </Reference>
    </SignedInfo>
    <SignatureValue>G9hWhCmhaFn4FYNU+ukYm4a8OfvFR5fZz9CYGj0XN5ayr43p2ugho7oCY1ySlwhrl0dTfnvQrE6S1IvD/W7LcS8PSnCx4G7X4wzZpTQojDAwbAZBBHjEe4Xhj7gIHRKhHvwiHwBsuBF64zZgUCcs91SgVJNFc1pfor/RP37pfwfFNQtobhvvFak99J0aPsHsmYoPeQBH2HzrmGfqLvZvpZQX7xJlpgU/D/wPxWpSTjHUOr2UegT0LYMPudpUQ96rBLgByvwx2rkJ+fmXz94T9WNPQxRyhJduDjChCFkwqFZ+3Ik4+s3LiQDVM/MonHvXB9BPIYRJOjiN3C6Nc3WMSA==</SignatureValue>
    <KeyInfo>
      <X509Data>
        <X509Certificate>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</X509Certificate>
      </X509Data>
    </KeyInfo>
  </Signature>
</CFe>''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DANFE / NFC-E'),
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
                      'Cole o XML do DANFE',
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
                        hintText: 'Cole aqui o XML da nota fiscal...',
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
                            _dadosDanfe = controller.parseXml(
                              _xmlController.text,
                            );
                          });
                        },
                        icon: const Icon(Icons.receipt_long),
                        label: const Text('Processar Nota'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_dadosDanfe != null) ...[
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
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showImagePreview(context),
                            icon: const Icon(Icons.image),
                            label: const Text('Preview Imagem'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final profile = await CapabilityProfile.load();
                              await controller.printDefault(
                                danfe: _dadosDanfe,
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
                        'Informações da Nota',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      dadosNota(_dadosDanfe),
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
    final imageDanfe = ImageDanfe.fromDanfe(
      danfe: _dadosDanfe!,
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
                title: const Text('Pré-visualização'),
                automaticallyImplyLeading: false,
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
    final imageDanfe = ImageDanfe.fromDanfe(
      danfe: _dadosDanfe!,
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
                    title: const Text('Preview - Imagem'),
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

  Widget dadosNota(Danfe? nota) {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                nota?.tipo == TipoDocumento.CFe ? ' Nota SAT' : 'Nota NFC-E',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Nome fantasia:  ',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    TextSpan(
                      text: nota?.dados?.emit?.xFant ?? '',
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
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'CNPJ:  ',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    TextSpan(
                      text: nota?.dados?.emit?.cnpj ?? '',
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
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Chave da nota:  ',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    TextSpan(
                      text: nota?.dados?.chaveNota ?? '',
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
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Número da nota:  ',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    TextSpan(
                      text: nota?.dados?.ide?.nNF ?? '',
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
            const Center(child: Text('Produtos')),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(),
              itemCount: nota?.dados?.det?.length ?? 0,
              itemBuilder: (_, index) {
                final Det? prod = nota?.dados?.det?[index];
                return ListTile(
                  leading: Text(prod?.prod?.qCom ?? ''),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: prod?.prod?.xProd ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: ' (${prod?.prod?.vProd ?? ''}) ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: (prod?.prod?.vDesc != null)
                      ? Text('Desconto: ${prod?.prod?.vDesc ?? ''}')
                      : const SizedBox(),
                  trailing: Text(prod?.prod?.vItem ?? ''),
                );
              },
            ),
            const Center(child: Text('Dados de pagamento')),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(),
              itemCount: nota?.dados?.pgto?.formas?.length ?? 0,
              itemBuilder: (_, index) {
                final MP? pgto = nota?.dados?.pgto?.formas?[index];
                return ListTile(
                  leading: Text(pgto?.cMP ?? ''),
                  title: Text(pgto?.vMP ?? ''),
                );
              },
            ),
            Visibility(
              visible:
                  (nota?.dados?.total?.desconto != '0.00' &&
                  nota?.dados?.total?.desconto != null),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Desconto na conta: ',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                      text: nota?.dados?.total?.desconto,
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
            Visibility(
              visible:
                  (nota?.dados?.pgto?.vTroco != '0.00' &&
                  nota?.dados?.pgto?.vTroco != null),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Troco: ',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                      text: nota?.dados?.pgto?.vTroco ?? '',
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
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Total da conta: ',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  TextSpan(
                    text: nota?.dados?.total?.valorTotal,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
