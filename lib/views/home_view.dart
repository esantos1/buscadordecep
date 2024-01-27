import 'package:buscadordecep/controller/home_controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewController = HomeController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Buscador de endereço'),
        ),
        body: viewController.model.screensItems[_currentIndex].child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (newIndex) => setState(() => _currentIndex = newIndex),
          items: viewController.model.screensItems
              .map((e) => e.itemButton)
              .toList(),
        ),
      );
}
