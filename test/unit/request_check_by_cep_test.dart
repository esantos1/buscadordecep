import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/controller/check_by_cep_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testando o retorno da requisição por CEP na API ViaCep', () async {
    CheckByCepController cepSearchController = CheckByCepController();
    Address address = await cepSearchController.fetchAddress('01001000');

    expect(address.logradouro, 'Praça da Sé');
  });
}
