import 'package:danfe/danfe.dart';
import 'home_controller.dart';
import 'package:flutter/material.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

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
                    controller: _xmlController,
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
