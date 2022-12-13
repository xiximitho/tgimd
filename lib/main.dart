import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tgimd/components/models/session_items.dart';
import 'package:tgimd/components/screens/card_history_screen.dart';
import 'package:tgimd/components/screens/ocr_screen.dart';
import 'package:tgimd/components/screens/play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionItems>(
      create: (context) => SessionItems(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          backgroundColor: Colors.grey,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          PlayScreen.routeName: (context) => const PlayScreen(),
          OcrScreen.routeName: (context) => const OcrScreen(),
          CardHistory.routeName: (context) => const CardHistory()
        },
        initialRoute: PlayScreen.routeName,
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
