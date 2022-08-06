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
