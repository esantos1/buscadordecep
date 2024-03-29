import 'package:buscadordecep/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buscador de Endereço',
        theme: ThemeData(
          primaryColor: Colors.teal,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          // useMaterial3: true,
        ),
        home: HomeView(),
      );
}
