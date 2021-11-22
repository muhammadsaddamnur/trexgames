import 'package:flutter/material.dart';
import 'package:trex/collision/collision.dart';

class MainPlayer extends StatelessWidget {
  const MainPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Collision(
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}
