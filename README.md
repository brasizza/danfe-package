# DANFE

Este package tem como finalidade ajudar no desenvolvimento e manipulação de documentos fiscais eletrônicos, incluindo DANFE (NFC-E, SAT, NFe) e NFSe Nacional, normalizando os objetos e criando buffers de impressão padrão para dispositivos ESC/POS.

## O que este package faz!
- [x] **DANFE**: Carrega um XML em string, verifica se é SAT, NFC-E ou NFe e normaliza um objeto com todas as informações em propriedades genéricas
- [x] **NFSe Nacional**: Carrega um XML de NFSe Nacional e normaliza um objeto com todas as informações
- [x] **Impressão**: Cria um buffer em List<int> com layout padrão para impressoras ESC/POS
- [x] **Conversão**: Transforma documentos em widgets Flutter, imagens ou JSON para impressão
- [x] **Customização**: Permite criar seus próprios layouts de impressão (vide pasta EXAMPLE)




# Existe um exemplo completo na pasta example do projeto

---

## 📄 Trabalhando com DANFE (NFC-E, SAT, NFe)

## Parseando seu XML em um objeto do tipo Danfe

```dart
// importando o package
import 'package:danfe/danfe.dart';

Danfe? danfe = DanfeParser.readFromString(xml);
```

## Transformando seu objeto em um buffer para impressão (Utilizando o esc_pos_utils)

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

DanfePrinter danfePrinter = DanfePrinter(PaperSize.mm80); // ou PaperSize.mm58
List<int> _dados = await danfePrinter.bufferDanfe(danfe);
```

## Imprimindo o buffer em uma impressora de rede

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

DanfePrinter danfePrinter = DanfePrinter(PaperSize.mm80); // ou PaperSize.mm58
final profile = await CapabilityProfile.load();
List<int> _dados = await danfePrinter.bufferDanfe(danfe);

NetworkPrinter printer = NetworkPrinter(PaperSize.mm80, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(_dados);
printer.disconnect();
```

## Convertendo DANFE em Widget Flutter

```dart
import 'package:danfe/danfe.dart';

// Converte o DANFE em JSON normativo
DanfePrinter danfePrinter = DanfePrinter(PaperSize.mm80);
String jsonDanfe = danfePrinter.normativeJsonDanfe(
  danfe,
  mostrarMoeda: true, // Exibir símbolo R$ (padrão: true)
  customFont: 'RobotoMonoRegular', // Fonte customizada (padrão: 'RobotoMonoRegular')
);

// Cria o widget
ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonDanfe,
  paperSize: DanfePaperSize.mm80,
);

Widget danfeWidget = await imageDanfe.toWidget(context);
```

## Convertendo DANFE em Imagem

```dart
import 'package:danfe/danfe.dart';

DanfePrinter danfePrinter = DanfePrinter(PaperSize.mm80);
String jsonDanfe = danfePrinter.normativeJsonDanfe(
  danfe,
  customFont: 'RobotoMonoBold', // Opcional: as fontes que estao no seu APP ou fontes diretamente do SO destino
);

ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonDanfe,
  paperSize: DanfePaperSize.mm80,
);

Uint8List imageBytes = await imageDanfe.toImage(context);
```

## Imprimindo DANFE diretamente da imagem (ESC/POS)

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

DanfePrinter danfePrinter = DanfePrinter(PaperSize.mm80);
String jsonDanfe = danfePrinter.normativeJsonDanfe(
  danfe,
  customFont: 'RobotoMonoMedium',
);

ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonDanfe,
  paperSize: DanfePaperSize.mm80,
);

// Converte para partes de imagem otimizadas para impressão térmica
List<Uint8List> imageParts = await imageDanfe.toEscPosPrinter(
  context,
  maxHeight: 2000,
  maxWidth: 576, // 576 para 80mm, 384 para 58mm
  margin: 0,
  fixedRatio: 1.0,
);

// Imprime cada parte da imagem
final profile = await CapabilityProfile.load();
final generator = Generator(PaperSize.mm80, profile);
List<int> bytes = [];

for (var imagePart in imageParts) {
  final image = decodeImage(imagePart);
  if (image != null) {
    bytes += generator.imageRaster(image);
  }
}

bytes += generator.cut();

// Envia para a impressora
NetworkPrinter printer = NetworkPrinter(PaperSize.mm80, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(bytes);
printer.disconnect();
```

## Imprimindo um layout diferente do padrão criado por você manualmente

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

final CustomPrinter custom = CustomPrinter(PaperSize.mm80); // ou PaperSize.mm58
final profile = await CapabilityProfile.load();
List<int> _dados = await custom.layoutCustom(danfe);

NetworkPrinter printer = NetworkPrinter(PaperSize.mm80, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(_dados);
printer.disconnect();
```

---

## 📄 Trabalhando com NFSe Nacional

> **⚠️ IMPORTANTE**: Este package suporta apenas **NFSe Nacional**. A identificação é feita pelo campo `versaoAplicativo` no XML que deve conter a palavra "Nacional" (case insensitive).

### Parseando XML de NFSe Nacional em um objeto

```dart
import 'package:danfe/danfe.dart';

// O XML deve ser de NFSe Nacional (versaoAplicativo contendo "Nacional")
Nfse? nfse = NfseParser.readFromString(xmlNfse);
```

### Verificando se o XML é NFSe Nacional

```dart
import 'package:danfe/danfe.dart';

// Extrai informações básicas sem fazer parse completo
Map<String, String>? info = NfseParser.extractBasicInfo(xmlNfse);

if (info != null) {
  print('Tipo: ${info['tipo']}'); // 'NFSe Nacional'
  print('Versão: ${info['versao']}');
  print('Número: ${info['numero']}');
}
```

### Transformando NFSe em buffer para impressão

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

NfsePrinter nfsePrinter = NfsePrinter(PaperSize.mm80); // ou PaperSize.mm58
List<int> _dados = await nfsePrinter.bufferNfse(nfse);
```

### Imprimindo NFSe em uma impressora de rede

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

NfsePrinter nfsePrinter = NfsePrinter(PaperSize.mm80);
final profile = await CapabilityProfile.load();
List<int> _dados = await nfsePrinter.bufferNfse(nfse);

NetworkPrinter printer = NetworkPrinter(PaperSize.mm80, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(_dados);
printer.disconnect();
```

### Convertendo NFSe em Widget Flutter

```dart
import 'package:danfe/danfe.dart';

// Converte a NFSe em JSON normativo
NfsePrinter nfsePrinter = NfsePrinter(PaperSize.mm80);
String jsonNfse = nfsePrinter.normativeJsonNfse(nfse);

// Cria o widget
ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonNfse,
  paperSize: DanfePaperSize.mm80,
);

Widget nfseWidget = await imageDanfe.toWidget(context);
```

### Convertendo NFSe em Imagem

```dart
import 'package:danfe/danfe.dart';

NfsePrinter nfsePrinter = NfsePrinter(PaperSize.mm80);
String jsonNfse = nfsePrinter.normativeJsonNfse(nfse);

ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonNfse,
  paperSize: DanfePaperSize.mm80,
);

Uint8List imageBytes = await imageDanfe.toImage(context);
```

### Imprimindo NFSe diretamente da imagem (ESC/POS)

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

NfsePrinter nfsePrinter = NfsePrinter(PaperSize.mm80);
String jsonNfse = nfsePrinter.normativeJsonNfse(nfse);

ImageDanfe imageDanfe = ImageDanfe(
  jsonData: jsonNfse,
  paperSize: DanfePaperSize.mm80,
);

// Converte para partes de imagem otimizadas para impressão térmica
List<Uint8List> imageParts = await imageDanfe.toEscPosPrinter(
  context,
  maxHeight: 2000,
  maxWidth: 576, // 576 para 80mm, 384 para 58mm
  margin: 0,
  fixedRatio: 1.0,
);

// Imprime cada parte da imagem
final profile = await CapabilityProfile.load();
final generator = Generator(PaperSize.mm80, profile);
List<int> bytes = [];

for (var imagePart in imageParts) {
  final image = decodeImage(imagePart);
  if (image != null) {
    bytes += generator.imageRaster(image);
  }
}

bytes += generator.cut();

// Envia para a impressora
NetworkPrinter printer = NetworkPrinter(PaperSize.mm80, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(bytes);
printer.disconnect();
```

### Exemplo de XML NFSe Nacional

```xml
<?xml version="1.0" encoding="UTF-8"?>
<root>
  <tipoAmbiente>1</tipoAmbiente>
  <versaoAplicativo>SefinNacional_1.5.0</versaoAplicativo>
  <NFSe>
    <infNFSe Id="NFS...">
      <nNFSe>1537</nNFSe>
      <emit>
        <CNPJ>12345678901234</CNPJ>
        <xNome>Empresa Exemplo LTDA</xNome>
        <enderNac>
          <xLgr>Rua Exemplo</xLgr>
          <nro>123</nro>
          <xBairro>Centro</xBairro>
          <cMun>3550308</cMun>
          <UF>SP</UF>
          <CEP>01310100</CEP>
        </enderNac>
      </emit>
      <DPS>
        <infDPS>
          <prest>
            <CNPJ>12345678901234</CNPJ>
          </prest>
          <tomador>
            <CNPJ>98765432109876</CNPJ>
            <xNome>Cliente Exemplo</xNome>
          </tomador>
          <serv>
            <cServ>
              <cTribNac>01.07.00</cTribNac>
              <xDescServ>Servico de Exemplo</xDescServ>
            </cServ>
          </serv>
          <valores>
            <vServPrest>
              <vServ>1000.00</vServ>
            </vServPrest>
          </valores>
        </infDPS>
      </DPS>
    </infNFSe>
  </NFSe>
</root>
```

---

## 🎨 Fontes Customizadas

O package inclui três variantes da fonte RobotoMono que podem ser usadas na impressão:

- `RobotoMonoRegular` - Fonte regular (padrão)
- `RobotoMonoMedium` - Fonte média
- `RobotoMonoBold` - Fonte negrito

Você pode especificar a fonte ao gerar o JSON normativo:

```dart
// Para DANFE
String jsonDanfe = danfePrinter.normativeJsonDanfe(
  danfe,
  customFont: 'RobotoMonoBold',
);

// Para NFSe (usa RobotoMonoRegular por padrão)
String jsonNfse = nfsePrinter.normativeJsonNfse(nfse);
```

## 🛠️ JsonPrinterHelper

Classe auxiliar que centraliza métodos comuns para criação de estruturas JSON de impressão. Útil se você quiser criar layouts customizados:

```dart
import 'package:danfe/danfe.dart';

final helper = JsonPrinterHelper(fontName: 'RobotoMonoBold');

// Criar linha customizada
Map linha = helper.prepareLine(
  content: 'Texto customizado',
  bold: true,
  fontSize: 14,
  aligment: 1, // 0: esquerda, 1: centro, 2: direita
);

// Criar divisor
Map divisor = helper.divider();

// Criar QR Code
Map qrcode = helper.prepareQrcode(
  content: 'https://exemplo.com',
  size: 160,
  level: 'H',
);

// Criar coluna de itens
Map coluna = helper.createColumnItems(
  paperSize: PaperSize.mm80,
  det: danfe.dados?.det,
);
```

---

## 📦 Modelos Disponíveis

### DANFE
- `Danfe` - Modelo principal
- `DadosDanfe` - Dados da nota
- `Emit` - Emitente
- `Dest` - Destinatário
- `Det` - Detalhes/Itens
- `Total` - Totalizadores
- `Pgto` - Pagamentos
- E outros...

### NFSe Nacional
- `Nfse` - Modelo principal
- `EmitNfse` - Emitente
- `InfDPS` - Informações da DPS
- `Prestador` - Dados do prestador
- `Tomador` - Dados do tomador
- `Servico` - Serviços prestados
- `Valores` - Valores da NFSe
- `Tributos` - Tributos aplicados


