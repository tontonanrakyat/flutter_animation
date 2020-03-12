import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController _controllerX;
  AnimationController _controllerY;
  AnimationController _controllerZ;
  Animation _animationX;
  Animation _animationZ;

  @override
  void initState() {
    super.initState();
    _controllerX = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(() {
        // print(_animation.value);
        setState(() {});
      });
    _animationX = Tween<double>(begin: 0.0, end: 150.0).animate(
        CurvedAnimation(parent: _controllerX, curve: Curves.bounceOut));
    // _controller.forward();

    _controllerY = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..addListener(() {
        // print(_animation.value);
        setState(() {});
      });

    _controllerZ = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..addListener(() {
        // print(_animation.value);
        setState(() {});
      });
    _animationZ = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 150.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 150.0, end: 50.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 40,
      ),
    ]).animate(
        CurvedAnimation(parent: _controllerZ, curve: Interval(0.0, 1.0)));
  }

  @override
  void dispose() {
    super.dispose();
    _controllerX.dispose();
    _controllerY.dispose();
    _controllerZ.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
          titleSpacing: 0,
        ),
        body: SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      width: _animationX.value,
                      height: _animationX.value,
                      color: Colors.green[200],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GrowingContainer(controller: _controllerY),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: _animationZ.value,
                      height: _animationZ.value,
                      color: Colors.red[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: () {
                _controllerX.repeat(
                  reverse: true,
                );
                // _controllerX.forward();
                _controllerY.reset();
                _controllerY.forward();
                _controllerZ.reset();
                _controllerZ.forward();
              },
            ),
            SizedBox(height: 30.0),
            FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () {
                _controllerX.reset();
                _controllerY.reset();
                _controllerZ.reset();
              },
            ),
          ],
        ));
  }
}

class GrowingContainer extends AnimatedWidget {
  GrowingContainer({AnimationController controller})
      : super(
            listenable: Tween<double>(begin: 0.0, end: 150.0).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOut)));

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Container(
      width: animation.value,
      height: animation.value,
      color: Colors.purple[200],
    );
  }
}
