import 'package:buscadordecep/controller/home_controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final viewController = HomeController();

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: viewController.model.tabsScreens.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Buscador de endereço'),
            centerTitle: true,
            bottom: TabBar(
              tabs: viewController.model.tabsScreens
                  .map((e) => e.tabBar)
                  .toList(),
            ),
          ),
          body: TabBarView(
            children:
                viewController.model.tabsScreens.map((e) => e.child).toList(),
          ),
        ),
      );
}
