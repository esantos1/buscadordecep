import 'dart:convert';

import 'package:buscadordecep/classes/address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buscadordecep/model/check_by_cep_model.dart';

class CheckByCepController extends ChangeNotifier {
  //instância do model
  final model = CheckByCepModel();

  //funções de requisição
  Future<Address> fetchData(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);

      if (body.containsKey('erro') && body['erro']) {
        throw Exception('CEP não encontrado');
      } else {
        Address address = Address.fromJson(json.decode(body));

        print(address.toString());

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
  void searchButtonClicked() {}
}
