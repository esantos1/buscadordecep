import 'package:buscadordecep/model/tabbar_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final tabsScreens = [
    TabBarModel(
      tabBar: Tab(text: 'Pelo nome da rua'),
      child: Center(child: Text('Pelo nome da rua')),
    ),
    TabBarModel(
      tabBar: Tab(text: 'Pelo CEP'),
      child: Center(child: Text('Pelo CEP')),
    ),
  ];

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabsScreens.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Buscador de endereço'),
            centerTitle: true,
            bottom: TabBar(
              tabs: tabsScreens.map((e) => e.tabBar).toList(),
            ),
          ),
          body: TabBarView(
            children: tabsScreens.map((e) => e.child).toList(),
          ),
        ),
      );
}
