import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'game/Game2048.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Score(),
    child: MaterialApp(
      home: MyGame(),
    )
  ));
}

class Score with ChangeNotifier {
  /// 当前分数
  int  currentScore = 0;
  /// 历史最高分
  int highestScore = 0;

  getCur() => currentScore;
  getHigh() => highestScore;

  clearScore() {
    currentScore = 0;
  }

  void setScore(int s) {
    currentScore += s;
    if (currentScore > highestScore) {
      highestScore = currentScore;
    }
  }
}

class MyGame extends StatelessWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
   // Score.clearScore;
    return Game2048();
  }

}
