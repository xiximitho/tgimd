import 'package:flutter/material.dart';
import 'package:tgimd/widgets/player_area_widget.dart';
import 'package:tgimd/widgets/screens/ocr_screen.dart';

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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(
                indicatorColor: Colors.black54,
                tabs: [
                  Tab(
                    text: 'MTG',
                    height: 12,
                  ),
                  Tab(
                    text: 'OCR',
                    height: 12,
                  ),
                ],
              ),
              title: const Text('Flutter Mobile Vision'),
            ),
            body: TabBarView(
              children: [
                GridView.count(
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
                ocrScreen(),
              ],
            )),
      ),
    );
  }
}
/*
GridView.count(
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
            )
*/
