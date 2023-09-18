import 'package:buscadordecep/classes/tabbar_class.dart';
import 'package:buscadordecep/views/check_by_address_view.dart';
import 'package:buscadordecep/views/check_by_cep_view.dart';
import 'package:flutter/material.dart';

class HomeModel {
  final tabsScreens = [
    TabBarClass(
      tabBar: Tab(text: 'Pelo nome da rua'),
      child: CheckByAddressView(),
    ),
    TabBarClass(
      tabBar: Tab(text: 'Pelo CEP'),
      child: CheckByCepView(),
    ),
  ];
}
