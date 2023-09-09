import 'package:buscadordecep/classes/tabbar_class.dart';
import 'package:flutter/material.dart';

class HomeModel {
  final tabsScreens = [
    TabBarClass(
      tabBar: Tab(text: 'Pelo nome da rua'),
      child: Center(child: Text('Pelo nome da rua')),
    ),
    TabBarClass(
      tabBar: Tab(text: 'Pelo CEP'),
      child: Center(child: Text('Pelo CEP')),
    ),
  ];
}
