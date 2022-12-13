import 'package:flutter/material.dart';
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
      body: _playerArea(context, playerCount.playerCounter),
    );
  }

//Lógica para a area do jogador
  Widget _playerArea(BuildContext context, int playerCounter) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: PlayerAreaWidget(
                invert: true,
              )),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.yellow],
                      stops: [0, 1],
                      begin: AlignmentDirectional(2, 0),
                      end: AlignmentDirectional(0, 25),
                    ),
                  ),
                  child: const ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: null, child: Text("\$"))
                      ]),
                ),
              ),
              Expanded(
                  child: PlayerAreaWidget(
                invert: false,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
