
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_app/page/home/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  int _count = 4;
  TimerUtil _timerUtil;

  @override
  void initState() {
    _doCountDown();
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status ==AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()), (route) => route == null);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/MainPage');
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
       _count = _tick.toInt(); 
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new FadeTransition(
            opacity: _animation,
            child: new Image.asset(
              'assets/images/splash.gif',
              width: double.infinity,
              fit:BoxFit.fill,
              height: double.infinity,
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                _goMain();
              },
              child: new Container(
                padding: EdgeInsets.all(12),
                child: new Text('跳过 $_count s', style: new TextStyle(fontSize: 14, color: Colors.white),),
                decoration: new BoxDecoration(
                  color: Color(0x66000000),
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  border: new Border.all(
                    width: 0.33,
                    color: Colors.blue[50],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}