import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/select_color.dart';

class CardOcrWidget extends StatelessWidget {
  final String ocrText;

  const CardOcrWidget(this.ocrText, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.title),
      title: Text(ocrText),
      trailing: const Icon(Icons.arrow_forward),
    );
  }
}

class CardHistory extends StatefulWidget {
  static const routeName = '/card-history';
  const CardHistory({super.key});

  @override
  CardHistoryState createState() => CardHistoryState();
}

class CardHistoryState extends State<CardHistory> {
  late SessionItems ocrWords;

  @override
  Widget build(BuildContext context) {
    ocrWords = context.watch<SessionItems>();
    return Scaffold(
      appBar: AppBar(),
      body: _getOcrWords(context),
    );
  }

  Widget _getOcrWords(BuildContext context) {
    List<Widget> items = [];

    items.addAll(
      ListTile.divideTiles(
        context: context,
        tiles: ocrWords.readOcr
            .map(
              (ocrText) => CardOcrWidget(ocrText),
            )
            .toList(),
      ),
    );

    return ListView(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      children: items,
    );
  }
}
