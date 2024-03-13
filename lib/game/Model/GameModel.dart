//
// import 'dart:math';
//
// enum Side { NORTH, EAST, SOUTH, WEST }
//
// class Model {
//   Board board;
//   int score;
//   int maxScore;
//   bool gameOver;
//
//   static const int MAX_PIECE = 2048;
//
//   Model(int size) {
//     board = Board(size);
//     score = maxScore = 0;
//     gameOver = false;
//   }
//
//   Model.fromRawValues(List<List<int>> rawValues, int score, int maxScore, bool gameOver) {
//     int size = rawValues.length;
//     board = Board.fromRawValues(rawValues, score);
//     this.score = score;
//     this.maxScore = maxScore;
//     this.gameOver = gameOver;
//   }
//
//   bool get isGameOver {
//     _checkGameOver();
//     if (gameOver) {
//       maxScore = max(score, maxScore);
//     }
//     return gameOver;
//   }
//
//   int get boardSize => board.size;
//
//   bool get hasEmptySpace => board.hasEmptySpace();
//
//   bool get hasMaxTile => board.hasMaxTile();
//
//   bool get hasValidMove => board.hasValidMove();
//
//   void clear() {
//     score = 0;
//     gameOver = false;
//     board.clear();
//   }
//
//   void addTile(Tile tile) {
//     board.addTile(tile);
//     _checkGameOver();
//   }
//
//   bool tilt(Side side) {
//     bool changed = false;
//     board.setViewingPerspective(side);
//
//     for (int c = 0; c < board.size; c++) {
//       for (int r = board.size - 1; r >= 0; r--) {
//         Tile t = board.tile(c, r);
//         int row = r;
//         if (t != null) {
//           for (int i = board.size - 1; i > r; i--) {
//             if (board.tile(c, i) == null) {
//               board.move(c, i, t);
//               row = i;
//               changed = true;
//               break;
//             }
//           }
//           for (int i = row - 1; i >= 0; i--) {
//             if (board.tile(c, i) != null && t.value != board.tile(c, i).value) {
//               break;
//             } else if (board.tile(c, i) != null && t.value == board.tile(c, i).value) {
//               board.move(c, row, board.tile(c, i));
//               changed = true;
//               score += board.tile(c, row).value;
//               break;
//             }
//           }
//         }
//       }
//     }
//     board.setViewingPerspective(Side.NORTH);
//     _checkGameOver();
//     return changed;
//   }
//
//   void _checkGameOver() {
//     gameOver = Board.isGameOver(board);
//   }
// }
//
// class Board {
//   List<List<Tile?>> _tiles;
//
//   Board(int size) {
//     _tiles = List.generate(size, (_) => List<Tile?>.filled(size, null));
//   }
//
//   Board.fromRawValues(List<List<int>> rawValues, int score) {
//     int size = rawValues.length;
//     _tiles = List.generate(size, (i) => List<Tile?>.filled(size, null));
//     for (int r = 0; r < size; r++) {
//       for (int c = 0; c < size; c++) {
//         if (rawValues[r][c] != 0) {
//           _tiles[r][c] = Tile(rawValues[r][c]);
//         }
//       }
//     }
//   }
//
//   int get size => _tiles.length;
//
//   bool hasEmptySpace() {
//     for (int r = 0; r < size; r++) {
//       for (int c = 0; c < size; c++) {
//         if (_tiles[r][c] == null) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   bool hasMaxTile() {
//     for (int r = 0; r < size; r++) {
//       for (int c = 0; c < size; c++) {
//         if (_tiles[r][c]?.value == Model.MAX_PIECE) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   bool hasValidMove() {
//     if (hasEmptySpace()) {
//       return true;
//     }
//
//     for (int r = 0; r < size; r++) {
//       for (int c = 0; c < size; c++) {
//         if ((c - 1 >= 0 && c + 1 < size) &&
//             (_tiles[r][c]?.value == _tiles[r][c - 1]?.value || _tiles[r][c]?.value == _tiles[r][c + 1]?.value)) {
//           return true;
//         } else if ((r - 1 >= 0 && r + 1 < size) &&
//             (_tiles[r][c]?.value == _tiles[r - 1][c]?.value || _tiles[r][c
//
//             ]?.value == _tiles[r + 1][c]?.value)) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   void clear() {
//     _tiles.forEach((row) => row.fillRange(0, size, null));
//   }
//
//   void addTile(Tile tile) {
//     for (int r = 0; r < size; r++) {
//       for (int c = 0; c < size; c++) {
//         if (_tiles[r][c] == null) {
//           _tiles[r][c] = tile;
//           return;
//         }
//       }
//     }
//   }
//
//   Tile? tile(int col, int row) {
//     return _tiles[row][col];
//   }
//
//   void move(int col, int row, Tile tile) {
//     _tiles[row][col] = tile;
//   }
//
//   void setViewingPerspective(Side side) {
// // Implementation not provided, it depends on your specific requirements.
// // This method would rotate the board to match the given side.
//   }
//
//   static bool isGameOver(Board b) {
//     return maxTileExists(b) || !atLeastOneMoveExists(b);
//   }
//
//   static bool maxTileExists(Board b) {
//     for (int r = 0; r < b.size; r++) {
//       for (int c = 0; c < b.size; c++) {
//         if (b.tile(c, r)?.value == Model.MAX_PIECE) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
//
//   static bool atLeastOneMoveExists(Board b) {
//     if (b.hasEmptySpace()) return true;
//     for (int r = 0; r < b.size; r++) {
//       for (int c = 0; c < b.size; c++) {
//         if ((c - 1 >= 0 && c + 1 < b.size) &&
//             (b.tile(c - 1, r)?.value == b.tile(c, r)?.value || b.tile(c + 1, r)?.value == b.tile(c, r)?.value)) {
//           return true;
//         } else if ((r - 1 >= 0 && r + 1 < b.size) &&
//             (b.tile(c, r - 1)?.value == b.tile(c, r)?.value || b.tile(c, r + 1)?.value == b.tile(c, r)?.value)) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
// }
//
// class Tile {
//   final int value;
//   Tile(this.value);
// }
