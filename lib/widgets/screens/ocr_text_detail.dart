import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

///
///
///
class OcrTextDetail extends StatefulWidget {
  final OcrText ocrText;

  const OcrTextDetail(this.ocrText, {super.key});

  @override
  OcrTextDetailState createState() => OcrTextDetailState();
}

///
///
///
class OcrTextDetailState extends State<OcrTextDetail> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Details'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(widget.ocrText.value),
            subtitle: const Text('Value'),
          ),
          ListTile(
            title: Text(widget.ocrText.language),
            subtitle: const Text('Language'),
          ),
          ListTile(
            title: Text(widget.ocrText.top.toString()),
            subtitle: const Text('Top'),
          ),
          ListTile(
            title: Text(widget.ocrText.bottom.toString()),
            subtitle: const Text('Bottom'),
          ),
          ListTile(
            title: Text(widget.ocrText.left.toString()),
            subtitle: const Text('Left'),
          ),
          ListTile(
            title: Text(widget.ocrText.right.toString()),
            subtitle: const Text('Right'),
          ),
        ],
      ),
    );
  }
}
