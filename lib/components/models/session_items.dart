import 'package:flutter/material.dart';

/// The [SessionItems] class holds a list of favorite items saved by the user.
class SessionItems extends ChangeNotifier {
  final List<String> _ocrWords = [];

  List<String> get readOcr => _ocrWords;

  void add(String itemNo) {
    _ocrWords.add(itemNo);
    notifyListeners();
  }

  void remove(String itemNo) {
    _ocrWords.remove(itemNo);
    notifyListeners();
  }

  int _playerCounter = 2;

  int get playerCounter => _playerCounter;

  set playerCounter(int playerCounter) {
    _playerCounter = playerCounter;
    notifyListeners();
  }
}
