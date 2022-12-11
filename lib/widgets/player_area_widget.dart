import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PlayerAreaWidget extends StatefulWidget {
  const PlayerAreaWidget(
      {super.key,
      this.color = const Color(0xFFFFE306),
      this.child,
      required this.invert});

  final Color color;
  final bool invert;
  //Caso necessite passar um child
  final Widget? child;

  @override
  State<PlayerAreaWidget> createState() => _PlayerAreaWidgetState();
}

class _PlayerAreaWidgetState extends State<PlayerAreaWidget> {
  //
  //
  Color _actualColor = Colors.yellow;
  int _life = 20;

  void changeColor(Color color) {
    setState(() {
      _actualColor = color;
    });
  }

  void _increaseLife() {
    setState(() {
      _life += 1;
    });
  }

  void _decreaseLife() {
    setState(() {
      _life -= 1;
    });
  }

  void _resetLife() {
    setState(() {
      _life = 20;
    });
  }

  void _callPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(14),
          title: const Text('Change color'),
          backgroundColor: Colors.white70,
          alignment: Alignment.center,
          content: SingleChildScrollView(
              child: BlockPicker(
            pickerColor: _actualColor,
            onColorChanged: changeColor,
          )),
          actions: [
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _actualColor,
      //transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.invert
              ? ButtonBar(
                  children: [
                    IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.stay_primary_portrait_rounded))
                  ],
                )
              : ButtonBar(
                  children: [
                    IconButton(
                        onPressed: _callPicker,
                        icon: const Icon(Icons.settings)),
                    IconButton(
                        onPressed: _resetLife,
                        icon: const Icon(Icons.restart_alt_outlined))
                  ],
                ),
          Row(
            children: [
              Expanded(
                  child: widget.invert
                      ? IconButton(
                          onPressed: _increaseLife,
                          icon: const Icon(
                            Icons.add,
                            size: 32,
                          ))
                      : IconButton(
                          onPressed: _decreaseLife,
                          icon: const Icon(
                            Icons.remove,
                            size: 32,
                          ))),
              Expanded(
                  child: widget.invert
                      ? RotatedBox(
                          quarterTurns: 2,
                          child: Text(
                            _life.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 60),
                          ),
                        )
                      : Text(
                          _life.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 60),
                        )),
              Expanded(
                  child: widget.invert
                      ? IconButton(
                          onPressed: _decreaseLife,
                          icon: const Icon(
                            Icons.remove,
                            size: 32,
                          ))
                      : IconButton(
                          onPressed: _increaseLife,
                          icon: const Icon(
                            Icons.add,
                            size: 32,
                          ))),
            ],
          ),
          widget.invert
              ? ButtonBar(
                  children: [
                    IconButton(
                        onPressed: _callPicker,
                        icon: const Icon(Icons.settings)),
                    IconButton(
                        onPressed: _resetLife,
                        icon: const Icon(Icons.restart_alt_outlined))
                  ],
                )
              : const ButtonBar(
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.stay_primary_portrait_rounded))
                  ],
                ),
        ],
      ),
    );
  }
}
