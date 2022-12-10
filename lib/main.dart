import 'package:flutter/material.dart';
import 'package:tgimd/PlayerAreaWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Thanks God It\'s Magic Day',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 97, 96, 96),
          body: GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 5,
            children: const [
              PlayerAreaWidget(
                color: Colors.red,
                invert: true,
              ),
              PlayerAreaWidget(
                color: Colors.indigo,
                invert: false,
              )
            ],
          ),
        ));
  }
}
