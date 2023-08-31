import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Danfe exemplos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _xmlController = TextEditingController();
  final HomeController controller = HomeController();
  Danfe? _dadosDanfe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  'Testes de danfes',
                ),
              ),
              Column(
                children: [
                  const Text('Cole aqui o seu xml da danfe'),
                  TextField(
                    controller: _xmlController
                      ..text =
                          r'''<CFe><infCFe Id="CFe23221233040747000637592302005660000041065401" versao="0.08" versaoDadosEnt="0.08" versaoSB="050004"><ide><cUF>23</cUF><cNF>106540</cNF><mod>59</mod><nserieSAT>230200566</nserieSAT><nCFe>000004</nCFe><dEmi>20221222</dEmi><hEmi>121248</hEmi><cDV>1</cDV><tpAmb>1</tpAmb><CNPJ>15120049000155</CNPJ><signAC>eZW1X8vaNbBAhAsN7gvtcj8JPaXQdAjTQz2BR761OEzTOrpc/p13imWQsGQojBNvd4aQunXFPiMzXZCoWNAc3NJOn2Rc/qyhtHB4x0ZSffo1Df2J0zdBUa1dMEs0A8FYSdcwQr/r2gqnuYSZVotpZGZGu93ixqiert/EXDYYBUmhW/q5AfRpQUJDEJvnibv1DnZXmD1KlM9d+pZQTiaqzA8HLXZ14wpwUKZIzhNxtzivYV9KAAUblcsbyEKLNS+10tp9i3SvSSISizsuh6i3U8TxHDH2S4DS2uFjGfPT47M2QOzQvby1t0ZMnnHPAX+USMDxmKWuKgy4o28RV3hQSA==</signAC><assinaturaQRCODE>Hk+by19lgiU9lQbSDCpzY+k9ryPchSEzF6qohhn0f/qMj1qu5GHJ8lcIB4TKlb5BX3/lxeUoZ2CWmelClwJ4RA1aQO3DgJDrow5gVIykc/rcFStzTCxthVGBrKCwILnikuAwrbLCBu34QDKXcsjSyYhDF1UGYlHsMeU2BHnPayMz3jcCQBjBYvcpdqYxYzjjZCCOTihsqpMfayVDRSO67qkgf39qxYaHuiSC1+eqAv2iK535cg+A3KrUQptzNMpNmSCeEWMt4yvdqlr5eLEvIlwAOd+nEm+7Jmti7SsxzRsHqacv8P5LcmTADK3NSXollz1Kwqwr/wQof2oIRnH+rQ==</assinaturaQRCODE><numeroCaixa>062</numeroCaixa></ide><emit><CNPJ>33040747000637</CNPJ><xNome>TBRP RESTAURANTE LTDA</xNome><xFant>TATU BOLA FORTALEZA</xFant><enderEmit><xLgr>REPUBLICA DO LIBANO</xLgr><nro>01084</nro><xBairro>MEIRELES</xBairro><xMun>FORTALEZA</xMun><CEP>60160140</CEP></enderEmit><IE>000071029966</IE><IM>7644868</IM><cRegTrib>3</cRegTrib><indRatISSQN>S</indRatISSQN></emit><dest></dest><det nItem="1"><prod><cProd>1001100032</cProd><xProd>RED BULL TROPICAL PEQ</xProd><NCM>22011000</NCM><CFOP>5405</CFOP><uCom>UN</uCom><qCom>2.0000</qCom><vUnCom>20.000</vUnCom><vProd>40.00</vProd><indRegra>A</indRegra><vItem>40.00</vItem></prod><imposto><ICMS><ICMS40><Orig>0</Orig><CST>60</CST></ICMS40></ICMS><PIS><PISNT><CST>06</CST></PISNT></PIS><COFINS><COFINSNT><CST>06</CST></COFINSNT></COFINS></imposto></det><det nItem="2"><prod><cProd>1001400009</cProd><xProd>MOSCOW MULE</xProd><NCM>22085000</NCM><CFOP>5405</CFOP><uCom>UN</uCom><qCom>3.0000</qCom><vUnCom>26.800</vUnCom><vProd>80.40</vProd><indRegra>A</indRegra><vItem>80.40</vItem></prod><imposto><ICMS><ICMS40><Orig>0</Orig><CST>60</CST></ICMS40></ICMS><PIS><PISNT><CST>06</CST></PISNT></PIS><COFINS><COFINSNT><CST>06</CST></COFINSNT></COFINS></imposto></det><det nItem="3"><prod><cProd>1001900011</cProd><xProd>GIN DOSE PEQ</xProd><NCM>22085000</NCM><CFOP>5405</CFOP><uCom>UN</uCom><qCom>2.0000</qCom><vUnCom>7.900</vUnCom><vProd>15.80</vProd><indRegra>A</indRegra><vItem>15.80</vItem></prod><imposto><ICMS><ICMS40><Orig>0</Orig><CST>60</CST></ICMS40></ICMS><PIS><PISNT><CST>06</CST></PISNT></PIS><COFINS><COFINSNT><CST>06</CST></COFINSNT></COFINS></imposto></det><det nItem="4"><prod><cProd>7008000002</cProd><xProd>COUVERT 7,90</xProd><NCM>00000099</NCM><CFOP>5933</CFOP><uCom>UN</uCom><qCom>1.0000</qCom><vUnCom>7.900</vUnCom><vProd>7.90</vProd><indRegra>A</indRegra><vItem>7.90</vItem></prod><imposto><ISSQN><vDeducISSQN>0.00</vDeducISSQN><vBC>7.90</vBC><vAliq>005.00</vAliq><vISSQN>0.40</vISSQN><cMunFG>2304400</cMunFG><cListServ>12.06</cListServ><cNatOp>05</cNatOp><indIncFisc>1</indIncFisc></ISSQN><PIS><PISSN><CST>49</CST></PISSN></PIS><COFINS><COFINSSN><CST>49</CST></COFINSSN></COFINS></imposto></det><det nItem="5"><prod><cProd>7007000001</cProd><xProd>Gorjeta concedida</xProd><NCM>21069090</NCM><CFOP>5102</CFOP><uCom>UN</uCom><qCom>1.0000</qCom><vUnCom>13.620</vUnCom><vProd>13.62</vProd><indRegra>A</indRegra><vItem>13.62</vItem></prod><imposto><ICMS><ICMS40><Orig>0</Orig><CST>41</CST></ICMS40></ICMS><PIS><PISNT><CST>08</CST></PISNT></PIS><COFINS><COFINSNT><CST>08</CST></COFINSNT></COFINS></imposto></det><total><ICMSTot><vICMS>0.00</vICMS><vProd>149.82</vProd><vDesc>0.00</vDesc><vPIS>0.00</vPIS><vCOFINS>0.00</vCOFINS><vPISST>0.00</vPISST><vCOFINSST>0.00</vCOFINSST><vOutro>0.00</vOutro></ICMSTot><vCFe>157.72</vCFe><ISSQNtot><vBC>7.90</vBC><vISS>0.40</vISS><vPIS>0.00</vPIS><vCOFINS>0.00</vCOFINS><vPISST>0.00</vPISST><vCOFINSST>0.00</vCOFINSST></ISSQNtot></total><pgto><MP><cMP>01</cMP><vMP>157.72</vMP></MP><vTroco>0.00</vTroco></pgto><infAdic><infCpl>- :Nacional: R$ 0,00 Estadual: R$ 0,00 Municipal: R$ 0,00 Importado: R$ F:766</infCpl></infAdic></infCFe><Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"></CanonicalizationMethod><SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"></SignatureMethod><Reference URI="#CFe23221233040747000637592302005660000041065401"><Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"></Transform><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"></Transform></Transforms><DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"></DigestMethod><DigestValue>qUsNqUoOWzxrXeOqmfdkVhC1cC4lOhGlnwLacYYX1vg=</DigestValue></Reference></SignedInfo><SignatureValue>pw89Z6wpjlYGzZGKTtvwBgW0YvT2fzmh1YqhHqDuFGsy0Auajxr4GCay0wWlCbCT2xKRcDK+4BqQ/FUUDqBP9hzzO7B5f6FYhCaH7z1h5ZiPxh6A9bsdq9Jvs9rGUEihV+IhSkkWAt0NJhio/xa4wLJKxDUbamBJZb2/sH/HtcgLfcefAuGryYHsIkb6Kr2VU7R2OscWOXuhL4Q+BZdhWRe8Gkrq3wF9HbinGm+ZOiJrJSIH08IPLWfqRucl5zKqm+hZmA9plxHKRI87FyhqEh+VhzmMzrNCbKu84rum6u/uPEIlu15m+wNvWe+1oOwKhjsjBFIJ50Z1RnqKOfmyrw==</SignatureValue><KeyInfo><X509Data><X509Certificate>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</X509Certificate></X509Data></KeyInfo></Signature></CFe>''',
                    maxLines: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _dadosDanfe =
                                      controller.parseXml(_xmlController.text);
                                });
                              },
                              child: const Text('Processar nota'))),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                final profile = await CapabilityProfile.load();

                                await controller.printDefault(
                                    danfe: _dadosDanfe,
                                    paper: PaperSize.mm80,
                                    profile: profile);
                              },
                              child: const Text('Imprimir nota'))),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                final profile = await CapabilityProfile.load();

                                await controller.printCustomLayout(
                                    danfe: _dadosDanfe,
                                    paper: PaperSize.mm80,
                                    profile: profile);
                              },
                              child:
                                  const Text('Imprimir minha customizacao'))),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Resultado da nota'),
                    dadosNota(_dadosDanfe),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dadosNota(Danfe? nota) {
    return Container(
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(nota?.tipo == 'CFe' ? ' Nota SAT' : 'Nota NFC-E')),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Nome fantasia:  ',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                TextSpan(
                  text: nota?.dados?.emit?.xFant ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'CNPJ:  ',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                TextSpan(
                  text: nota?.dados?.emit?.cnpj ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Chave da nota:  ',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                TextSpan(
                  text: nota?.dados?.chaveNota ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Número da nota:  ',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                TextSpan(
                  text: nota?.dados?.ide?.nNF ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
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
                      text: TextSpan(children: [
                    TextSpan(
                      text: prod?.prod?.xProd ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                      text: ' (' + (prod?.prod?.vProd ?? '') + ') ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ])),
                  subtitle: (prod?.prod?.vDesc != null)
                      ? Text('Desconto: ' + (prod?.prod?.vDesc ?? ''))
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
              visible: (nota?.dados?.total?.desconto != '0.00' &&
                  nota?.dados?.total?.desconto != null),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Desconto na conta: ',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                TextSpan(
                  text: nota?.dados?.total?.desconto,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
            ),
            Visibility(
              visible: (nota?.dados?.pgto?.vTroco != '0.00' &&
                  nota?.dados?.pgto?.vTroco != null),
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Troco: ',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                TextSpan(
                  text: nota?.dados?.pgto?.vTroco ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ])),
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: 'Total da conta: ',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              TextSpan(
                text: nota?.dados?.total?.valorTotal,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
