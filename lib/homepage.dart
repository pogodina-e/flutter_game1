// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_game/barriers.dart';
import 'package:flutter_game/constant/constants.dart';
import 'package:flutter_game/database/database.dart';
import 'package:flutter_game/functions.dart';
import 'package:flutter_game/models/bird.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

final myBox = Hive.box('user');

@override
void initState() {
  init();
  initState();
}

class _HomePageState extends State<HomePage> {
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  void resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      score = 0;
      initialHeight = birdY;
      barrierXOne = 1;
      barrierXTwo = barrierXOne + 1.7;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.5 * time;
      setState(() {
        birdY = initialHeight - height;
      });
      if (barrierXOne < -2) {
        barrierXOne += 3.5;
      } else {
        barrierXOne -= 0.05;
      }
      if (barrierXTwo < -2) {
        barrierXTwo += 3.5;
      } else {
        barrierXTwo -= 0.05;
      }
      if (birdY > 0.7 || birdY < -0.7) {
        timer.cancel();
        _showDialog();
      }
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (birdY > 0.7 || birdY < -0.7) {
        write("score", topScore);
        timer.cancel();
        score = 0;
      } else {
        setState(() {
          if (score == topScore) {
            topScore++;
          }
          score++;
        });
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              actions: [
                gameButton(() {
                  resetGame();
                }, "Попробовать снова", Colors.green),
              ],
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              title: const Text(
                "..Oops",
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 35,
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment(0, birdY),
                        duration: const Duration(milliseconds: 0),
                        color: Colors.blueAccent,
                        child: MyBird(),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: gameHasStarted
                            ? const Text(" ")
                            : const Text(
                                "НАЖМИТЕ ЧТОБЫ НАЧАТЬ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                      AnimatedContainer(
                          alignment: Alignment(barrierXOne, 1.1),
                          duration: const Duration(milliseconds: 0),
                          child: const MyBarrier(
                            size: 200.0,
                          )),
                      AnimatedContainer(
                          alignment: Alignment(barrierXOne, -1.1),
                          duration: const Duration(milliseconds: 0),
                          child: const MyBarrier(
                            size: 200.0,
                          )),
                      AnimatedContainer(
                          alignment: Alignment(barrierXTwo, 1.1),
                          duration: const Duration(milliseconds: 0),
                          child: const MyBarrier(
                            size: 170.0,
                          )),
                      AnimatedContainer(
                          alignment: Alignment(barrierXTwo, -1.1),
                          duration: const Duration(milliseconds: 0),
                          child: const MyBarrier(
                            size: 250.0,
                          )),
                    ],
                  )),
              Container(
                height: 15,
                color: Colors.green,
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Результат: $score",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Рекорд: $topScore",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
