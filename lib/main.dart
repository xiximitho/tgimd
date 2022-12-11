import 'package:flutter/material.dart';
import 'package:tgimd/components/screens/ocr_screen.dart';
import 'package:tgimd/components/widgets/player_area_widget.dart';

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
        primarySwatch: Colors.blueGrey,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(
                padding: EdgeInsets.all(1),
                isScrollable: false,
                indicatorColor: Colors.black54,
                tabs: [
                  Tab(
                    text: 'MTG',
                    height: 0,
                  ),
                  Tab(
                    text: 'OCR',
                    height: 0,
                  ),
                ],
              ),
              title: const Text('Flutter Mobile Vision'),
            ),
            body: TabBarView(
              children: [
                GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1,
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
                const OcrScreen(),
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
