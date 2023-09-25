import 'dart:convert';

import 'package:buscadordecep/classes/address.dart';
import 'package:http/http.dart' as http;
import 'package:buscadordecep/model/check_by_cep_model.dart';

class CheckByCepController {
  final model = CheckByCepModel();

  Future<Address> fetchAddress(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Address a = Address.fromJson(json.decode(response.body));

      print(a.toString());

      return a;
    } else {
      throw Exception('Falha em fazer a requisição');
    }
  }
}
