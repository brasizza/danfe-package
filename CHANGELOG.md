
## 2.0.2
* Melhoria na fonte customizável
* Separação do core de geração do JSON para uma classe separada
* Para saber como utlizar as fontes: [pubspec.yaml](https://github.com/brasizza/danfe-package/blob/master/example/pubspec.yaml)

## 2.0.1
* Melhorando a impressão padrao da danfe printer,melhorando a fonte padrao
## 2.0.0
* Agora é possível parsear NFSE no modelo nacional
* Inclusao de um novo modelo de impressao onde pode te retornar uma imagem e/ou um widget para preview em tela, assim pode mandar a impressão direto via imagem para qualquer dispositivo

## 1.0.3
* Inclusão da tag de totais de tributos incidentes na impressao da danfe

## 1.0.2
* Melhoria na diferenciação entre NFE/NFC-E , com a inclusão da impressão do frete, inibição do QRCODE e identificação correta entre NFE/NFC-E no cabeçalho!

## 1.0.1
* Atualizando (NFE) para notas que o TRANSPORTA está vazio e tambem quando a nota nao contém duplicata!

## 1.0.0
* Atualizado para a última versão do flutter/dart (foi necessário subir o intl pra 0.20)
* Atualizado o exemplo pra kts (ultimo gradle do flutter novo)


## 0.1.0
* Melhorias na impressao, aumento do qrcode, removendo acentos de onde fui achando
* Melhorias na impressao, aumento do qrcode, inserindo mais dados importantes do emitente no cabeçalho da impressao

## 0.0.29
* change: As versoes mais novas do escpos_utils trocou o size de Size para size, quebrando alguns sistemas. atualizei o meu package para o ultimo escpos_utils, portanto no seu codigo pode haver algum problema do Size do qrcode, somente mudar para size minusculo


## 0.0.28
* fix: Duplicatas podem ser uma lista, alterado para receber uma lista de DUP  mesmo com somente uma duplicata

## 0.0.27
* Improve: Duplicatas podem ser uma lista, alterado para receber uma lista de DUP
## 0.0.26
* Improve: A pedidos no git, foi mapeado outros campos no ICMSTOT no model de totais

## 0.0.25
## 0.0.24
* Improve: Incrementando o nó transporte e cobrança nos dados de danfe no parses e na impresao!
* Melhoria na documentacao do componente para melhor visualizaçao na IDE
## 0.0.23
* Improve: Arrumando o calculo de desconto/acrescimo no SAT Tks to [@alessandro-amos](https://github.com/alessandro-amos)
## 0.0.22
## 0.0.21
* Improve: Preparando a danfe para um futuro package de json normativo que estou desenvolvendo.


## 0.0.20
* Improve: Imprimir os dados do consumidor quando for CNPJ Tks pelo xml de teste Tks to [@smorigo](https://github.com/smorigo)

## 0.0.19
* Improve: Diminuir o qrcode da danfe que estava muito grande!

## 0.0.18
* Improve: Melhoria de recebimento do protocolo quando é NFC-E da danfe Tks to [@EduardoDadalt](https://github.com/EduardoDadalt)
* Melhoria de impressão, agora estamos colocando o número do documento, serie e os numeros de procoloco quando é NFC-e e a data!
- Sem breakchanges


## 0.0.17
* Change:  Foi necessário fazer o fork do esc_pos_printer para atualizar dependencias e colocar no meu repositório **esc_pos_printer_plus**

## 0.0.16
* Improve:  Foi necessário tirar o valor unitário quando a impressão for a de 58mm por conta da colunagem.



## 0.0.15
* Improve: Corrigindo o calculo de desconto da danfe Tks to [@murilorissos](https://github.com/murilorissos)


## 0.0.14
* Improve: Comportando múltiplas formas de pagamento Tks to [@f-junior](https://github.com/f-junior)


## 0.0.13
* Improve: Incluindo a possibilidade de parsear um xml sem protocolo [@Hudson82011](https://github.com/Hudson82011)

## 0.0.12
* Improve: Novas formas de Pagamento de acordo com a NT 2020 Tks to [@f-junior](https://github.com/f-junior)

## 0.0.11
* Fix do pubspec pra levar o dart pro 4.0.0

## 0.0.10
* Atualização do **intl interno** de   *^0.17.0* para *^0.18.1*

## 0.0.9
* Criação do campo **vCFeLei12741** como *valorLei12741*

## 0.0.8
* Separação do *vDesc* e do *vRatDesc* em duas propriedades diferentes para facilitar o uso

## 0.0.7
* O nó DEST as vezes o sistema entendia NULL, as vezes Vazio, corrigido para sempre ser nulo


## 0.0.6
* Alteração de conversão de double pra string feita errada


## 0.0.5
* Inclusão da mensagem do fisco no final da nota
* A data na emissão agora é a data da nota e não mais a data atual

## 0.0.4
* Melhoria no modelo parão de impressão da danfe, colocando mais detalhado os descontos, acréscimos, troco e as formas de pagamento
* Retirado também do modelo os espaços que consumia muita bobina
* Melhoria no modo de criar seu próprio modelo de impressão. Você agora pode implementar a interface ***IDanfePrinter*** 
* Inclusão de uma propriedade para mostrar ou esconder o R$ nos valores.
* Externalização de uma classe DanfeUtils com metodos de ajuda como conversão de valores
* No exemplo, o custom printer tem exatamente o layout que uso na classe interna do package


## 0.0.3
* Melhoria no exemplo dentro do REAME
* Refatoração nas classes de modelos, colocando uma em cada pasta para facilitar futura manutenção
* Agora no exemplo o customPrinter extende a DanfePrinter para utilizar os metodos de lá

## 0.0.2
* Identação do README


## 0.0.1
* Início do projeto com as funcionalidades básicas de parsear o xml em um objeto e preparar o buffer para impressao.
