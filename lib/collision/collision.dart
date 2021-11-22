import 'package:flutter/material.dart';

class Collision extends StatelessWidget {
  final Widget child;
  const Collision({Key? key, required this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: Colors.yellow,
      child: child,
    );
  }
}
