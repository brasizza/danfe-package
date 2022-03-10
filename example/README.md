# DANFE



Este package tem como finalidade ajudar no desenvolvimento e manipulação das Danfes, seja NFC-E ou SAT, normalizando o objeto e também criando um buffer de uma impressão padrão para ser enviada para qualquer dispositivo que imprima ESC/POS


## O que este package faz!
- [x] Carrega um xml em string e verifica se é SAT ou NFC-E e normaliza um objeto com todas as informações em propriedades genéricas
- [x] Cria um buffer em List<int> com um layout especificado por mim, porém no seu projeto você mesmo pode criar o layout que achar necessário (vide pasta EXEMPLO)




# Existe um exemplo completo na pasta example do projeto




## Parseando seu xml em um objeto do tipo Danfe

```dart
// importando o package
import 'package:danfe/danfe.dart';
Danfe? danfe = DanfeParser.readFromString(xml);

```

## Transformando seu objeto em um buffer para impressão (Utilizando o esc_pos_utils)

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
DanfePrinter danfePrinter = DanfePrinter( PaperSize.mm80 ); // ou  PaperSize.mm50
List<int> _dados = await danfePrinter.bufferDanfe(danfe);

```


## Imprimindo o buffer em uma impressora de rede

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
DanfePrinter danfePrinter = DanfePrinter( PaperSize.mm80 ); // ou  PaperSize.mm50
final profile = await CapabilityProfile.load();
List<int> _dados = await danfePrinter.bufferDanfe(danfe);
NetworkPrinter printer = NetworkPrinter(paper, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(_dados);
printer.disconnect();

```


## Imprimindo um layout diferente do padrão criado por você manualmente

```dart
import 'package:danfe/danfe.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
final CustomPrinter custom = CustomPrinter(PaperSize.mm80); // ou  PaperSize.mm50
final profile = await CapabilityProfile.load();
List<int> _dados = await custom.layoutCustom(danfe);
NetworkPrinter printer = NetworkPrinter(paper, profile);
await printer.connect('192.168.5.111', port: 9100);
printer.rawBytes(_dados);
printer.disconnect();

```


