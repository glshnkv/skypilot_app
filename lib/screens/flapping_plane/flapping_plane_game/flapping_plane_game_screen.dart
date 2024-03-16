import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skypilot_app/router/router.dart';
import 'package:skypilot_app/screens/flapping_plane/models/plane_model.dart';
import 'package:skypilot_app/theme/colors.dart';
import 'package:skypilot_app/widgets/action_button_widget.dart';

@RoutePage()
class FlappingPlaneGameScreen extends StatefulWidget {
  final PlaneModel plane;
  final int coins;

  const FlappingPlaneGameScreen(
      {super.key, required this.plane, required this.coins});

  @override
  State<FlappingPlaneGameScreen> createState() =>
      _FlappingPlaneGameScreenState();
}

class _FlappingPlaneGameScreenState extends State<FlappingPlaneGameScreen> {
  double _left = 0;
  double _bottom = 0;

  double coins = 0;
  double coefficient = 1.0;
  bool gameStarted = false;
  int timerDuration = 0;
  Timer _timer = Timer(Duration(seconds: 0), () {});
  Timer _updateTimer = Timer(Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();
    gameStarted = true;
    startGame();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _left = MediaQuery.of(context).size.width;
        _bottom = MediaQuery.of(context).size.height;
      });
    });
  }

  void startGame() {
    timerDuration = Random().nextInt(16) + 5;

    if (gameStarted) {
      _updateTimer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        setState(() {
          coefficient += 0.01;
          coins = widget.coins * coefficient;
        });
      });
    }
    _timer = Timer(Duration(seconds: timerDuration), () {
      if (gameStarted) {
        context.router.push(ResultRoute(coins: 0, result: 'Lose'));
      }
    });
  }

  void stopGame() {
    if (gameStarted) {
      gameStarted = false;
      _timer.cancel();
      _updateTimer.cancel();
      double winnings = coins;
    }
  }

  void resetGame() {
    setState(() {
      _updateTimer.cancel();
      coins = 0;
      gameStarted = false;
      coefficient = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/flapping-plane/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'x${coefficient.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.black65,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/flapping-plane/coin.png', width: 32,),
                          SizedBox(width: 5),
                          Text(
                            '${coins.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AnimatedContainer(
                    duration: Duration(seconds: timerDuration+Random().nextInt(16) + 5),
                    curve: Curves.linear,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(bottom: _bottom, left: _left),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Lottie.asset(widget.plane.imageJson),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionButtonWidget(
          text: 'Stop',
          width: 350,
          onTap: () {
            stopGame();
            context.router.push(ResultRoute(coins: coins, result: 'Win'));
          }),
    );
  }
}
