import 'dart:convert';

import 'package:buscadordecep/classes/address.dart';
import 'package:http/http.dart' as http;
import 'package:buscadordecep/model/check_by_cep_model.dart';

class CheckByCepController {
  //instância do model
  final model = CheckByCepModel();

  //funções de requisição
  Future<Address> fetchData(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      if (body.containsKey('erro') && body['erro']) {
        throw Exception('Não existe endereço para esse CEP.');
      } else {
        Address address = Address.fromJson(body);

        return address;
      }
    } else if (response.statusCode == 400) {
      throw Exception('CEP Inválido!');
    } else {
      throw Exception(
          'Desculpe, ocorreu um erro interno. Por Favor, tente novamente.');
    }
  }

  //funções de widgets
}
