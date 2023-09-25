import 'package:flutter/material.dart';

class CheckByAddressModel {
  static final ufs = [
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

  static final cityTest = [
    'Cidade A',
    'Cidade B',
    'Cidade C',
    'Cidade D',
    'Cidade E',
    'Cidade F',
    'Cidade G',
    'Cidade H',
    'Cidade I',
    'Cidade J',
  ];

  final dropdownUfItems = ufs
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  final dropdowncityTestItems = cityTest
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList();

  final txtStreetNameController = TextEditingController();
}
