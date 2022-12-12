import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

///
///
///
class CardDetail extends StatefulWidget {
  final OcrText ocrText;

  const CardDetail(this.ocrText, {super.key});

  @override
  CardDetailState createState() => CardDetailState();
}

///
///
///
class CardDetailState extends State<CardDetail> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(widget.ocrText.value),
            subtitle: const Text('Value'),
          ),
        ],
      ),
    );
  }
}
