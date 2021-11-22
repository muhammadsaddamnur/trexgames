import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trex/collision/collision.dart';

class Enemy extends StatefulWidget {
  const Enemy({
    Key? key,
  }) : super(key: key);

  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  double? left;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      setState(() {
        left = MediaQuery.of(context).size.width + 50;
      });

      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        left = -50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return left == null
        ? const SizedBox()
        : AnimatedPositioned(
            left: left,
            top: MediaQuery.of(context).size.height / 2,
            duration: const Duration(milliseconds: 1500),
            child: Collision(
              // key: widget.key,
              child: Container(
                color: Colors.blue,
                height: 50,
                width: 20,
              ),
            ));
  }
}
