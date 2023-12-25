import 'dart:convert';

import 'package:buscadordecep/classes/address.dart';
import 'package:buscadordecep/model/check_by_address_model.dart';
import 'package:http/http.dart' as http;

class CheckByAddressController {
  final model = CheckByAddressModel();

  Future<List<String>> getCities(String uf) async {
    List<String> cities = [];
    final url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      cities = body.map((e) => e['nome'] as String).toList();
    } else {
      throw Exception(
          'Ocorreu um erro ao buscar os municípios. Tente novamente mais tarde.');
    }

    return cities;
  }

  Future<List<Address>> getAddresses(
      String streetName, String uf, String city) async {
    final url = 'https://viacep.com.br/ws/$uf/$city/$streetName/json/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List<Address> addresses =
          body.map<Address>((item) => Address.fromJson(item)).toList();

      return addresses;
    } else if (response.statusCode == 400) {
      throw Exception('Endereço Inválido!');
    } else {
      throw Exception(
          'Desculpe, ocorreu um erro interno. Por Favor, tente novamente mais tarde.');
    }
  }
}
