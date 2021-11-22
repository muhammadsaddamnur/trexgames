// import 'package:flutter/material.dart';
// import 'package:trex/collision/collision.dart';

// class AnimatedWidgetExample extends StatefulWidget {
//   const AnimatedWidgetExample({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => AnimatedWidgetExampleState();
// }

// class AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   double? left;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     )..repeat();

//     _controller.addListener(() {
//       print('sasas');
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Woolha.com Flutter Tutorial'),
//       ),
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           child: Container(
//             width: 50,
//             height: 50,
//             color: Colors.teal,
//             child: const Center(
//               child: Text(
//                 'Woolha.com',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//           ),
//           builder: (BuildContext context, Widget? child) {
//             return SlideTransition(
//               position: Tween<Offset>(
//                 begin:
//                     Offset(MediaQuery.of(context).size.width / 2 / 50 + 0.5, 0),
//                 end: Offset(
//                     (MediaQuery.of(context).size.width / 2 / 50 + 0.5) * -1, 0),
//               ).animate(CurvedAnimation(
//                   curve: const Interval(0, 1, curve: Curves.linear),
//                   parent: _controller)),
//               child: child,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:trex/collision/collision.dart';

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedWidgetExampleState();
}

class AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  double? left;
  bool collide = false;
  int point = 0;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start({int duration = 1700}) {
    setState(() {
      _controller = AnimationController(
        duration: Duration(milliseconds: duration),
        vsync: this,
      )..repeat();
    });

    _controller.addListener(() async {
      await Future.delayed(Duration(milliseconds: 100));
      RenderBox box1 = GlobalObjectKey('player')
          .currentContext!
          .findRenderObject() as RenderBox;
      RenderBox box2 = GlobalObjectKey('enemy')
          .currentContext!
          .findRenderObject() as RenderBox;

      final size1 = box1.size;
      final size2 = box2.size;

      final position1 = box1.localToGlobal(Offset.zero);
      final position2 = box2.localToGlobal(Offset.zero);

      collide = (position1.dx < position2.dx + size2.width &&
          position1.dx + size1.width > position2.dx &&
          position1.dy < position2.dy + size2.height &&
          position1.dy + size1.height > position2.dy);

      if (point == 100) {
        await Future.delayed(Duration(milliseconds: 1000));
        start(duration: 500);

        setState(() {});
      }
      setState(() {});

      if (collide == true) {
        // _controller.stop();

        if (_controller.isAnimating) {
          _controller.dispose();
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Point ($point)'),
                      Text('Would you like to approve of this message?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Reset'),
                    onPressed: () {
                      setState(() {
                        collide = false;
                        point = 0;
                        start();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
      point++;

      setState(() {});
      print('Containers collide: $collide');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Text(point.toString() + ' ${_controller.duration}')),
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            child: Container(
              key: GlobalObjectKey('enemy'),
              width: 25,
              height: 50,
              color: Colors.teal,
            ),
            builder: (BuildContext context, Widget? child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(
                      MediaQuery.of(context).size.width / 2 / 25 + 0.5, 0),
                  end: Offset(
                      (MediaQuery.of(context).size.width / 2 / 25 + 0.5) * -1,
                      0),
                ).animate(CurvedAnimation(
                    curve: const Interval(0, 1, curve: Curves.linear),
                    parent: _controller)),
                child: child,
              );
            },
          ),
        ),
        if (collide == true)
          Positioned(
              bottom: 100,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        collide = false;
                        start();
                      });
                    },
                    child: Text('Reset'),
                  ),
                ),
              ))
      ],
    );
  }
}
