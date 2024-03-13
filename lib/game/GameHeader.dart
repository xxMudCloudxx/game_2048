import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/game/GameLogic.dart';
import 'package:game_2048/game/GamePanel.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Color.dart';
import 'Game2048.dart';


class GameHeader extends StatefulWidget {
  @override
  State<GameHeader> createState() => _GameHeader();
}

class _GameHeader extends State<GameHeader> {
  /// 用于获取 Game2048PanelState 实例，以便可以调用restartGame方法

  GameLogic logic = GameLogic();

  static const GAME_2048_HIGHEST_SCORE = "game_2048_highest_score";

  Future<SharedPreferences> _spFuture = SharedPreferences.getInstance();

  // void setScore(int s) {
  //   currentScore += s;
  //   if (currentScore > highestScore) {
  //     highestScore = currentScore;
  //   }
  // }
  // int getCurrentScore() => currentScore;
  // int getHighestScore() => highestScore;

  _GameHeader() {
    initState();
  }

  @override
  void initState() {
    super.initState();
    readHighestScoreFromSp();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: Column(
              children: [
                const Text("2048",
                  style: TextStyle(
                    fontSize: 75,
                    color: numColor,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 12,),
                newGame()
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 40, 25, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Consumer<Score>(builder:(context, currentScore, child) {
                    return NumCard(text:'SCORE', score:Provider.of<Score>(context, listen: false).currentScore);
                  }),
                  const SizedBox(height: 10,),
                  Consumer<Score>(builder:(context, highestScore, child) {
                    return NumCard(text:'HIGHEST', score:Provider.of<Score>(context, listen: false).highestScore);
                  })
                ]
            ),
          ),
        ]
    );
  }

  Container newGame() {
    return Container(
      height: 60,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: newGameColor
      ),
      child: InkWell(
        onTap: () {
          // 重新开始游戏，这里的逻辑之后再实现
        },
        child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('NEW GAME', style: TextStyle(
              color: whiteText, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 1,)
        ],
      ),
      ),
    );
  }

  Container NumCard({String? text, int? score}) {
    return Container(
        height: 80,
        width: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: numCardColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text!, style: const TextStyle(
                color: whiteText, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 1,),
            Text(score!.toString(), style: const TextStyle(color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),)
          ],
        )
    );
  }

  void readHighestScoreFromSp() async {
    final SharedPreferences sp = await _spFuture;
    setState(() {
      //Score.setScore(sp.getInt(GAME_2048_HIGHEST_SCORE) ?? 0);
    });
  }

  void storeHighestScoreToSp() async {
    final SharedPreferences sp = await _spFuture;
    //await sp.setInt(GAME_2048_HIGHEST_SCORE, Score.getHigh());
  }
}
