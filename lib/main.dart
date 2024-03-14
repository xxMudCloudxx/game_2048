import 'dart:math';

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

class MyGame extends StatelessWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Game2048();
  }

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
    notifyListeners();
  }

  static const int SIZE = 4;
  static List numMap = List.generate(SIZE, (_) => List<int>.generate(SIZE, (_) => 0));
  static void retile(int col, int row, int value) {
    numMap[col][row] = value;
  }

  int one = 1;

  static int size() {
    return numMap.length;
  }

  static int tile(int col, int row) {
    return numMap[col][row];
  }

  int tile1(int col, int row) {
    return numMap[col][row];
  }

  void NewGame() {
    clear();
    initGameMap();
    notifyListeners();
  }

  /// 初始化数据
  void initGameMap() {
    /// 执行两次随机
    randomNewCellData(2);
    randomNewCellData(4);
    notifyListeners();
  }

  static void initGameMap1() {
    /// 执行两次随机
    randomNewCellData1(2);
    randomNewCellData1(4);
  }


  void randomNewCellData(int data) {
    /// 在产生新的数字（块）时，
    /// 需要先判断下是否map中所有的数字都不为0
    /// 如果都不为0，就直接return，不产生新数字
    if (!hasEmptySpace()) {
      debugPrint("gameMap中都不是0，不能生成");
      return;
    }
    while (true) {
      Random random = Random();
      int randomI = random.nextInt(SIZE);
      int randomJ = random.nextInt(SIZE);
      if (tile(randomI, randomJ) == 0) {
        retile(randomI, randomJ, data);
        break;
      }
    }
  }

  static void randomNewCellData1(int data) {
    /// 在产生新的数字（块）时，
    /// 需要先判断下是否map中所有的数字都不为0
    /// 如果都不为0，就直接return，不产生新数字
    if (!hasEmptySpace()) {
      debugPrint("gameMap中都不是0，不能生成");
      return;
    }
    while (true) {
      Random random = Random();
      int randomI = random.nextInt(SIZE);
      int randomJ = random.nextInt(SIZE);
      if (tile(randomI, randomJ) == 0) {
        retile(randomI, randomJ, data);
        break;
      }
    }
  }

  static bool hasEmptySpace() {
    int length = size();
    for(int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        if (tile(i, j) == 0)
          return true;
      }
    }
    return false;
  }

  void clear() {
    for (int r = 0; r < size(); r++) {
      for (int c = 0; c < size(); c++) {
        retile(c, r, 0);
      }
    }
  }

  static void clear1() {
    for (int r = 0; r < size(); r++) {
      for (int c = 0; c < size(); c++) {
        retile(c, r, 0);
      }
    }
  }

}