import 'package:danfe/danfe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NfseParser', () {
    const xmlNfseNacional = '''<?xml version="1.0" encoding="UTF-8"?>
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

    const xmlNaoNfse = '''<?xml version="1.0"?>
<NFe>
  <infNFe>
    <ide>
      <cNF>123</cNF>
    </ide>
  </infNFe>
</NFe>''';

    test('Deve identificar NFSe Nacional corretamente', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);
      expect(nfse, isNotNull);
      expect(nfse!.infDPS, isNotNull);
    });

    test('Não deve identificar NFe como NFSe', () {
      final nfse = NfseParser.readFromString(xmlNaoNfse);
      expect(nfse, isNull);
    });

    test('Deve parsear dados básicos corretamente', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      expect(nfse, isNotNull);
      expect(nfse!.infDPS, isNotNull);
      expect(nfse.infDPS!.nDPS, equals('426673'));
      expect(nfse.infDPS!.serie, equals('2'));
      expect(nfse.infDPS!.tpAmb, equals('1'));
    });

    test('Deve parsear dados do prestador', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      expect(nfse!.infDPS!.prest, isNotNull);
      expect(nfse.infDPS!.prest!.cnpj, equals('123444444'));
      expect(nfse.infDPS!.prest!.regTrib, isNotNull);
      expect(nfse.infDPS!.prest!.regTrib!.opSimpNac, equals('1'));
    });

    test('Deve parsear dados do serviço', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      expect(nfse!.infDPS!.serv, isNotNull);
      expect(nfse.infDPS!.serv!.cServ, isNotNull);
      expect(
        nfse.infDPS!.serv!.cServ!.xDescServ,
        equals('SERVICOS REFERENTES A CONTA 393707'),
      );
      expect(nfse.infDPS!.serv!.cServ!.cTribNac, equals('171101'));
    });

    test('Deve parsear valores', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      expect(nfse!.infDPS!.valores, isNotNull);
      expect(nfse.infDPS!.valores!.vServPrest, isNotNull);
      expect(nfse.infDPS!.valores!.vServPrest!.vServ, equals('15.90'));
    });

    test('Deve parsear tributos', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      expect(nfse!.infDPS!.valores!.trib, isNotNull);
      expect(nfse.infDPS!.valores!.trib!.tribMun, isNotNull);
      expect(nfse.infDPS!.valores!.trib!.tribFed, isNotNull);
      expect(
        nfse.infDPS!.valores!.trib!.tribFed!.piscofins!.cst,
        equals('00'),
      );
    });

    test('Deve extrair informações básicas', () {
      final info = NfseParser.extractBasicInfo(xmlNfseNacional);

      expect(info['numero'], equals('426673'));
      expect(info['serie'], equals('2'));
      expect(info['cnpjPrestador'], equals('123444444'));
      expect(info['valorServico'], equals('15.90'));
      expect(
        info['descricaoServico'],
        equals('SERVICOS REFERENTES A CONTA 393707'),
      );
    });

    test('Deve converter para Map e JSON', () {
      final nfse = NfseParser.readFromString(xmlNfseNacional);

      final map = nfse!.toMap();
      expect(map, isNotNull);
      expect(map['infDPS'], isNotNull);

      final json = nfse.toJson();
      expect(json, isNotNull);
      expect(json, contains('426673'));
    });
  });
}
