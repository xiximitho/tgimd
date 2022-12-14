import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:provider/provider.dart';
import 'package:tgimd/components/models/session_items.dart';
import 'package:tgimd/components/screens/card_history_screen.dart';

import '../widgets/card_detail.dart';

class OcrTextWidget extends StatelessWidget {
  final OcrText ocrText;

  const OcrTextWidget(this.ocrText, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.title),
      title: Text(ocrText.value),
      subtitle: Text(ocrText.language),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CardDetail(ocrText),
        ),
      ),
    );
  }
}

class OcrScreen extends StatefulWidget {
  static const routeName = '/ocr';
  const OcrScreen({super.key});

  @override
  OcrScreenState createState() => OcrScreenState();
}

class OcrScreenState extends State<OcrScreen> {
  final int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  final bool _autoFocusOcr = true;
  final bool _torchOcr = false;
  final bool _multipleOcr = false;
  final bool _waitTapOcr = true;
  final bool _showTextOcr = true;
  Size? _previewOcr;
  List<OcrText> _textsOcr = [];
  late SessionItems ocrWords;
  @override
  void initState() {
    super.initState();

    FlutterMobileVision.start().then((previewSizes) => setState(() {
          _previewOcr = previewSizes[_cameraOcr]!.first;
        }));
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    ocrWords = context.watch<SessionItems>();
    return Scaffold(
      appBar: AppBar(),
      body: _getOcrScreen(context, ocrWords),
    );
  }

  ///
  /// OCR Screen
  ///
  Widget _getOcrScreen(BuildContext context, SessionItems session) {
    List<Widget> items = [];

    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          bottom: 12.0,
        ),
        child: ElevatedButton(
          onPressed: _read,
          child: const Text('Ler'),
        ),
      ),
    );

    items.addAll(
      ListTile.divideTiles(
        context: context,
        tiles: _textsOcr
            .map(
              (ocrText) => OcrTextWidget(ocrText),
            )
            .toList(),
      ),
    );

    items.add(Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: 12,
      ),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, CardHistory.routeName);
          },
          child: const Text("Analisar")),
    ));

    return ListView(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      children: items,
    );
  }

  ///
  /// OCR Method
  ///
  Future<void> _read() async {
    List<OcrText> texts = [];
    Size scanpreviewOcr = _previewOcr ?? FlutterMobileVision.PREVIEW;
    try {
      texts = await FlutterMobileVision.read(
        flash: _torchOcr,
        autoFocus: _autoFocusOcr,
        multiple: _multipleOcr,
        waitTap: _waitTapOcr,
        forceCloseCameraOnTap: true,
        //Opcional: caminho para salvar a imagem, vazio = n??o salvar
        imagePath: '', //'path/to/file.jpg'
        showText: _showTextOcr,
        preview: _previewOcr ?? FlutterMobileVision.PREVIEW,
        scanArea: Size(scanpreviewOcr.width - 20, scanpreviewOcr.height - 20),
        camera: _cameraOcr,
        fps: 2.0,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;
    ocrWords.add(texts.first.value);
    setState(() => _textsOcr = texts);
  }
}
