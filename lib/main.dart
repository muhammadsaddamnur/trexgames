import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trex/player/main_player.dart';

import 'enemy.dart/animation_builder_enemy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var widgetKey = GlobalKey();

class _MyHomePageState extends State<MyHomePage> {
  double top = 0;
  bool enableTap = true;
  late Timer timer;
  int count = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        top = (MediaQuery.of(context).size.height / 2) - 25;
        // enemy.add(const Enemy());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedWidgetExample();

    return Scaffold(
      body: GestureDetector(
        onTap: enableTap == false ? null : () async {},
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedWidgetExample(),
            AnimatedPositioned(
                left: 10,
                top: top,
                duration: const Duration(milliseconds: 300),
                child: const MainPlayer(
                  key: GlobalObjectKey('player'),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: enableTap == false
            ? null
            : () async {
                setState(() {
                  enableTap = false;
                  top = top - 150;
                });
                await Future.delayed(const Duration(milliseconds: 300));
                top = (MediaQuery.of(context).size.height / 2) - 25;
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 300));
                enableTap = true;
                setState(() {});
              },
      ),
    );
  }
}
