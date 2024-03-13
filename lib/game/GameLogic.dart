
import 'package:flutter/src/widgets/framework.dart';
import 'package:game_2048/game/GameMap.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'Game2048.dart';
import 'Model/Side.dart';

abstract class Logic {
  bool checkEnd(GameMap b);
  void reset(GameMap b);
}

class GameLogic implements Logic{
  bool gameover = false;
  static const int MAX_PIECE = 2048;

  bool gameOver(GameMap b) {
    gameover = checkEnd(b);
    return checkEnd(b);
  }

  @override
  void reset(GameMap b) {
    gameover = false;
    b.clear();
  }

  @override
  bool checkEnd(GameMap b) {
    return maxTileExists(b) || !atLeastOneMoveExists(b);
  }

  static bool maxTileExists(GameMap b) {
    for (int r = 0; r < b.size(); r++) {
      for (int c = 0; c < b.size(); c++) {
        if (b.tile(c, r) == MAX_PIECE) {
          return true;
        }
      }
    }
    return false;
  }

  static bool atLeastOneMoveExists(GameMap b) {
    if (b.hasEmptySpace()) return true;
    for (int r = 0; r < b.size(); r++) {
      for (int c = 0; c < b.size(); c++) {
        if ((c - 1 >= 0 && c + 1 < b.size()) &&
            (b.tile(c - 1, r) == b.tile(c, r) ||
                b.tile(c + 1, r) == b.tile(c, r))) {
          return true;
        } else if ((r - 1 >= 0 && r + 1 < b.size()) &&
            (b.tile(c, r - 1) == b.tile(c, r) ||
                b.tile(c, r + 1) == b.tile(c, r))) {
          return true;
        }
      }
    }
    return false;
  }
}