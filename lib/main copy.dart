import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trex/collision/collision.dart';
import 'package:trex/enemy.dart/enemy.dart';
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
  List<Widget> enemy = [];
  late Timer timer;
  int count = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        top = MediaQuery.of(context).size.height / 2;
        // enemy.add(const Enemy());
      });
    });

    setTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await setRandom();
    });
  }

  Future setRandom() async {
    if (enemy.length > 0) {
      await Future.delayed(Duration(seconds: 1));
      count = 0;
      enemy.clear();
    } else {
      // int random = Random().nextInt(2);
      // if (random == 0) {
      //   enemy.add(const Enemy());
      // } else {
      //   enemy.add(const Enemy());
      //   await Future.delayed(Duration(milliseconds: 500));
      //   enemy.add(const Enemy());
      // }
      setState(() {
        count++;
      });
      print('a$count');
      enemy.add(Enemy(
        key: GlobalObjectKey('a'),
      ));
    }
    print(enemy.length);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedWidgetExample();

    return Scaffold(
      body: GestureDetector(
        onTap: enableTap == false
            ? null
            : () async {
                // setState(() {
                //   enableTap = false;
                //   top = top - 150;
                // });
                // await Future.delayed(const Duration(milliseconds: 300));
                // setState(() {
                //   top = MediaQuery.of(context).size.height / 2;
                //   enableTap = true;
                // });
              },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Stack(
              fit: StackFit.expand,
              children: enemy.map((e) => e).toList(),
            ),
            AnimatedPositioned(
                left: 10,
                top: top,
                duration: const Duration(milliseconds: 300),
                child: const MainPlayer(
                  key: GlobalObjectKey('enemy1'),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: enableTap == false
            ? null
            : () async {
                RenderBox box = const GlobalObjectKey('a')
                    .currentContext!
                    .findRenderObject() as RenderBox;

                print(box.size.width);

                _onCheckTap();

                // RenderBox box2 =
                //     widgetKey.currentContext!.findRenderObject() as RenderBox;
                // print(box2.size.height);

                setState(() {
                  enableTap = false;
                  top = top - 150;
                });
                await Future.delayed(const Duration(milliseconds: 300));
                top = MediaQuery.of(context).size.height / 2;
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 300));
                enableTap = true;
                setState(() {});
              },
      ),
    );
  }

  void _onCheckTap() {
    RenderBox box1 = GlobalObjectKey('enemy1')
        .currentContext!
        .findRenderObject() as RenderBox;
    RenderBox box2 =
        GlobalObjectKey('a').currentContext!.findRenderObject() as RenderBox;

    final size1 = box1.size;
    final size2 = box2.size;

    final position1 = box1.localToGlobal(Offset.zero);
    final position2 = box2.localToGlobal(Offset.zero);

    final collide = (position1.dx < position2.dx + size2.width &&
        position1.dx + size1.width > position2.dx &&
        position1.dy < position2.dy + size2.height &&
        position1.dy + size1.height > position2.dy);

    print('Containers collide: $collide');
  }
}
