import 'package:flutter/material.dart';

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
  int _life = 20;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      //transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.invert
              ? const ButtonBar(
                  children: [
                    IconButton(
                        onPressed: null,
                        icon: Icon(Icons.stay_primary_portrait_rounded))
                  ],
                )
              : ButtonBar(
                  children: [
                    const IconButton(
                        onPressed: null, icon: Icon(Icons.settings)),
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
                    const IconButton(
                        onPressed: null, icon: Icon(Icons.settings)),
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
