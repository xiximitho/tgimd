import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

import 'ocr_text_detail.dart';

///
///
///
void main() => runApp(ocrScreen());

///
///
///
///
//////
/// OcrTextWidget
///
class OcrTextWidget extends StatelessWidget {
  final OcrText ocrText;

  const OcrTextWidget(this.ocrText);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.title),
      title: Text(ocrText.value),
      subtitle: Text(ocrText.language),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OcrTextDetail(ocrText),
        ),
      ),
    );
  }
}

class ocrScreen extends StatefulWidget {
  @override
  ocrScreenState createState() => ocrScreenState();
}

class ocrScreenState extends State<ocrScreen> {
  String _platformVersion = 'Unknown';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterMobileVision.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  final int _cameraBarcode = FlutterMobileVision.CAMERA_BACK;
  final int _onlyFormatBarcode = Barcode.ALL_FORMATS;
  final bool _autoFocusBarcode = true;
  final bool _torchBarcode = false;
  final bool _multipleBarcode = false;
  final bool _waitTapBarcode = false;
  final bool _showTextBarcode = false;
  Size? _previewBarcode;
  final List<Barcode> _barcodes = [];

  int? _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  bool _autoFocusOcr = true;
  bool _torchOcr = false;
  bool _multipleOcr = false;
  bool _waitTapOcr = false;
  bool _showTextOcr = true;
  Size? _previewOcr;
  List<OcrText> _textsOcr = [];

  final int _cameraFace = FlutterMobileVision.CAMERA_FRONT;
  final bool _autoFocusFace = true;
  final bool _torchFace = false;
  final bool _multipleFace = true;
  final bool _showTextFace = true;
  Size? _previewFace;
  final List<Face> _faces = [];

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    initPlatformState();
    FlutterMobileVision.start().then((previewSizes) => setState(() {
          if (previewSizes[_cameraBarcode] == null) {
            return;
          }
          _previewBarcode = previewSizes[_cameraBarcode]!.first;
          _previewOcr = previewSizes[_cameraOcr]!.first;
          _previewFace = previewSizes[_cameraFace]!.first;
        }));
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return _getOcrScreen(context);
  }

  ///
  /// Scan formats
  ///
  List<DropdownMenuItem<int>> _getFormats() {
    List<DropdownMenuItem<int>> formatItems = [];

    Barcode.mapFormat.forEach((key, value) {
      formatItems.add(
        DropdownMenuItem(
          value: key,
          child: Text(value),
        ),
      );
    });

    return formatItems;
  }

  ///
  /// Camera list
  ///
  List<DropdownMenuItem<int>> _getCameras() {
    List<DropdownMenuItem<int>> cameraItems = [];

    cameraItems.add(const DropdownMenuItem(
      value: FlutterMobileVision.CAMERA_BACK,
      child: Text('BACK'),
    ));

    cameraItems.add(const DropdownMenuItem(
      value: FlutterMobileVision.CAMERA_FRONT,
      child: Text('FRONT'),
    ));

    return cameraItems;
  }

  ///
  /// Preview sizes list
  ///
  List<DropdownMenuItem<Size>> _getPreviewSizes(int facing) {
    List<DropdownMenuItem<Size>> previewItems = [];

    List<Size>? sizes = FlutterMobileVision.getPreviewSizes(facing);

    if (sizes != null) {
      for (var size in sizes) {
        previewItems.add(
          DropdownMenuItem(
            value: size,
            child: Text(size.toString()),
          ),
        );
      }
    } else {
      previewItems.add(
        const DropdownMenuItem(
          value: null,
          child: Text('Empty'),
        ),
      );
    }

    return previewItems;
  }

  ///
  /// OCR Screen
  ///
  Widget _getOcrScreen(BuildContext context) {
    List<Widget> items = [];

    items.add(const Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 18.0,
        right: 18.0,
      ),
      child: Text('Camera:'),
    ));

    items.add(Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: DropdownButton<int>(
        items: _getCameras(),
        onChanged: (value) {
          _previewOcr = null;
          setState(() => _cameraOcr = value);
        },
        value: _cameraOcr,
      ),
    ));

    items.add(const Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 18.0,
        right: 18.0,
      ),
      child: Text('Preview size:'),
    ));

    items.add(Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: DropdownButton<Size>(
        items: _getPreviewSizes(_cameraOcr ?? 0),
        onChanged: (value) {
          setState(() => _previewOcr = value);
        },
        value: _previewOcr,
      ),
    ));

    items.add(SwitchListTile(
      title: const Text('Auto focus:'),
      value: _autoFocusOcr,
      onChanged: (value) => setState(() => _autoFocusOcr = value),
    ));

    items.add(SwitchListTile(
      title: const Text('Torch:'),
      value: _torchOcr,
      onChanged: (value) => setState(() => _torchOcr = value),
    ));

    items.add(SwitchListTile(
      title: const Text('Return all texts:'),
      value: _multipleOcr,
      onChanged: (value) => setState(() => _multipleOcr = value),
    ));

    items.add(SwitchListTile(
      title: const Text('Capture when tap screen:'),
      value: _waitTapOcr,
      onChanged: (value) => setState(() => _waitTapOcr = value),
    ));

    items.add(SwitchListTile(
      title: const Text('Show text:'),
      value: _showTextOcr,
      onChanged: (value) => setState(() => _showTextOcr = value),
    ));

    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          bottom: 12.0,
        ),
        child: ElevatedButton(
          onPressed: _read,
          child: const Text('READ!'),
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
        //OPTIONAL: close camera after tap, even if there are no detection.
        //Camera would usually stay on, until there is a valid detection
        forceCloseCameraOnTap: true,
        //OPTIONAL: path to save image to. leave empty if you do not want to save the image
        imagePath: '', //'path/to/file.jpg'
        showText: _showTextOcr,
        preview: _previewOcr ?? FlutterMobileVision.PREVIEW,
        scanArea: Size(scanpreviewOcr.width - 20, scanpreviewOcr.height - 20),
        camera: _cameraOcr ?? FlutterMobileVision.CAMERA_BACK,
        fps: 2.0,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;

    setState(() => _textsOcr = texts);
  }
}
