
import 'package:game_2048/game/GameMap.dart';
import '../main.dart';


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
  }

  @override
  bool checkEnd(GameMap b) {
    return maxTileExists(b) || !atLeastOneMoveExists(b);
  }

  static bool maxTileExists(GameMap b) {
    for (int r = 0; r < Score.size(); r++) {
      for (int c = 0; c < Score.size(); c++) {
        if (b.tile(c, r) == MAX_PIECE) {
          return true;
        }
      }
    }
    return false;
  }

  static bool atLeastOneMoveExists(GameMap b) {
    if (b.hasEmptySpace()) return true;
    for (int r = 0; r < Score.size(); r++) {
      for (int c = 0; c < Score.size(); c++) {
        if ((c - 1 >= 0 && c + 1 < Score.size()) &&
            (b.tile(c - 1, r) == b.tile(c, r) ||
                b.tile(c + 1, r) == b.tile(c, r))) {
          return true;
        } else if ((r - 1 >= 0 && r + 1 < Score.size()) &&
            (b.tile(c, r - 1) == b.tile(c, r) ||
                b.tile(c, r + 1) == b.tile(c, r))) {
          return true;
        }
      }
    }
    return false;
  }
}