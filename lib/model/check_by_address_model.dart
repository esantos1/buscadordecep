import 'package:flutter/material.dart';

class CheckByAddressModel {
  late final ufs = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  late List<String> cities = [];

  List<DropdownMenuItem<String>> buildDropdownUfItems() => ufs
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  List<DropdownMenuItem<String>> buildDropdownCitiesItems() => cities
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  String ufValue = '';
  String? cityValue = '';
}
