import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Color.dart';
import 'GameHeader.dart';
import 'GamePanel.dart';


class Game2048 extends StatefulWidget{

  @override
  State<Game2048> createState() => GameState();
}

class GameState extends State<Game2048> {
  GamePanel panel = GamePanel();
  GameHeader header= GameHeader();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 30),
        color: tan,
        child: Column(
          children: [
            Flexible(child: header),
            Flexible(flex: 2,child: panel)
          ],
        ),
        )
    );
  }
}