import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';
import 'package:tgimd/components/widgets/player_area_widget.dart';

import '../models/session_items.dart';

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

class PlayScreen extends StatefulWidget {
  static const routeName = '/play';
  const PlayScreen({super.key});

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  late SessionItems playerCount;

  @override
  Widget build(BuildContext context) {
    playerCount = context.watch<SessionItems>();
    return Scaffold(
      body: _playerArea(context, playerCount),
    );
  }

//Lógica para a area do jogador
  Widget _playerArea(BuildContext context, SessionItems playerCounter) {
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: _multiSplitView(context, playerCounter.playerCounter)),
    );
  }

  Widget _multiSplitView(BuildContext context, int playerCounter) {
    if (playerCounter == 4) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          MultiSplitView(axis: Axis.horizontal, children: [
            PlayerAreaWidget(invert: true),
            PlayerAreaWidget(invert: true),
          ]),
          MultiSplitView(children: [
            PlayerAreaWidget(invert: false),
            PlayerAreaWidget(invert: false),
          ])
        ],
      );
    } else if (playerCounter == 3) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          PlayerAreaWidget(invert: true),
          MultiSplitView(axis: Axis.horizontal, children: [
            PlayerAreaWidget(invert: false),
            PlayerAreaWidget(invert: false),
          ]),
        ],
      );
    } else if (playerCounter == 2) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          PlayerAreaWidget(invert: true),
          PlayerAreaWidget(invert: false),
        ],
      );
    } else {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          PlayerAreaWidget(invert: false),
        ],
      );
    }
  }
}
