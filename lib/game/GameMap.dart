
import 'package:provider/provider.dart';
import '../main.dart';

class GameMap {

  //Side viewPerspective = Side.NORTH;


  int size(context) => Score.size();

  // int vtile(int col, int row,Side side) {
  //   return _numMap[side.col(col, row, size())][side.row(col, row, size())];
  // }
  //
  // void vretile(int col, int row, int value,Side side) {
  //   _numMap[side.col(col, row, size())][side.row(col, row, size())] = value;
  // }


  int tile(int col, int row) {
    return Score.tile(col, row);
  }

  void retile(int col, int row, int value) {
    Score.retile(col, row, value);
  }

  bool hasEmptySpace() {
    return Score.hasEmptySpace();
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