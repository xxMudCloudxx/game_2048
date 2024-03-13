import 'Model/Side.dart';

class GameMap {
  static const int SIZE = 4;
  //Side viewPerspective = Side.NORTH;
  List _numMap = List.generate(SIZE, (_) => List<int>.generate(SIZE, (_) => 0));

  int size() => _numMap.length;

  // int vtile(int col, int row,Side side) {
  //   return _numMap[side.col(col, row, size())][side.row(col, row, size())];
  // }
  //
  // void vretile(int col, int row, int value,Side side) {
  //   _numMap[side.col(col, row, size())][side.row(col, row, size())] = value;
  // }


  int tile(int col, int row) {
    return _numMap[col][row];
  }

  void retile(int col, int row, int value) {
    _numMap[col][row] = value;
  }

  void clear() {
    for (int r = 0; r < size(); r++) {
      for (int c = 0; c < size(); c++) {
        retile(c, r, 0);
      }
    }
  }

  bool hasEmptySpace() {
    int length = size();
    for(int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        if (tile(i, j) == 0)
          return true;
      }
    }
    return false;
  }
  //
  // bool move(int col, int row, int tile_col, int tile_row) {
  //   print("move work");
  //   int pcol = viewPerspective.col(col, row, size()),
  //       prow = viewPerspective.row(col, row, size());
  //   if (tile_col == pcol && tile_row == prow) {
  //     return false;
  //   }
  //   int tile1 = vtile(col, row, viewPerspective);
  //   int newPlaceValue = tile(pcol, prow) + tile(tile_col, tile_row);
  //   int preValue = _numMap[tile_col][tile_row];
  //   _numMap[tile_col][tile_row] = 0;
  //   if (tile1 == 0) {
  //     _numMap[pcol][prow] = preValue;
  //     return true;
  //   } else {
  //     _numMap[pcol][prow] = newPlaceValue;
  //     return true;
  //   }
  //   //
  //   // map.retile(tile_col, tile_row, newPlaceValue);
  //   // map.retile(col, row, 0);
  // }
  //
  // void setViewingPerspective(Side s) {
  //   viewPerspective = s;
  // }
  //
  //
}