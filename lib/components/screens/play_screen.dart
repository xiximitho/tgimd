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
  late SessionItems sessionPlayers;

  @override
  Widget build(BuildContext context) {
    sessionPlayers = context.watch<SessionItems>();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _callPlayerSetter(context, sessionPlayers);
          },
          mini: true,
          backgroundColor: Colors.blueGrey[200],
          child: const Icon(Icons.settings)),
      body: _playerArea(context, sessionPlayers),
    );
  }

  void _callPlayerSetter(BuildContext context, SessionItems playerCounter) {
    List<int> list = [1, 2, 3, 4];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: const [],
            title: const Text("Player number"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            backgroundColor: Colors.blueGrey[200],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: DropdownButton(
              value: playerCounter.playerCounter,
              items: list.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (int? value) {
                // This is called when the user selects an item.
                setState(() {
                  playerCounter.playerCounter = value!;
                  Navigator.pop(context);
                });
              },
            ),
          );
        });
  }

//Lógica para a area do jogador
  Widget _playerArea(BuildContext context, SessionItems sessionItems) {
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: _multiSplitView(context, sessionItems)),
    );
  }

  Widget _multiSplitView(BuildContext context, SessionItems sessionItems) {
    if (sessionItems.playerCounter == 4) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          MultiSplitView(axis: Axis.horizontal, children: const [
            PlayerAreaWidget(invert: true),
            PlayerAreaWidget(invert: true),
          ]),
          MultiSplitView(children: const [
            PlayerAreaWidget(invert: false),
            PlayerAreaWidget(invert: false),
          ])
        ],
      );
    } else if (sessionItems.playerCounter == 3) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: [
          const PlayerAreaWidget(invert: true),
          MultiSplitView(axis: Axis.horizontal, children: const [
            PlayerAreaWidget(invert: false),
            PlayerAreaWidget(invert: false),
          ]),
        ],
      );
    } else if (sessionItems.playerCounter == 2) {
      return MultiSplitView(
        axis: Axis.vertical,
        children: const [
          PlayerAreaWidget(invert: true),
          PlayerAreaWidget(invert: false),
        ],
      );
    } else {
      return MultiSplitView(
        axis: Axis.vertical,
        children: const [
          PlayerAreaWidget(invert: false),
        ],
      );
    }
  }
}
