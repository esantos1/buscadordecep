import 'package:buscadordecep/controller/check_by_address_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Testando se há retorno de dados na requisição que busca municípios na API do IBGE',
      () async {
    final controllerByAddressController = CheckByAddressController();
    const uf = 'AP';
    final cities = await controllerByAddressController.getCities(uf);

    //vou testar a partir do número de municípios da uf instanciada
    //deve retornar 16
    expect(cities.length, 16);
  });

  test(
      'Testando se há retorno de dados na requisição que busca dados na API do ViaCep',
      () async {
    final controllerByAddressController = CheckByAddressController();
    final cities = await controllerByAddressController.getAddresses(
        'Domingos', 'RS', 'Porto Alegre');

    //vou testar a partir do número de possíveis CEPs
    //deve retornar 16
    expect(cities.length, 16);
  });
}
