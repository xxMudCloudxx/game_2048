// import 'dart:math';
//
// /// Represents the image of a numbered tile on a 2048 board.
// class Tile {
//   /// A new tile with [value] as its value at ([col], [row]). This
//   /// constructor is private, so all tiles are created by the
//   /// factory methods create, move, and merge.
//   Tile(this.value, this.col, this.row) : next = null;
//
//   /// Return my current row.
//   int getRow() => row;
//
//   /// Return my current column.
//   int getCol() => col;
//
//   /// Return the value supplied to my constructor.
//   int getValue() => value;
//
//   /// Return my next state. Before I am moved or merged, I am my
//   /// own successor.
//   Tile getNext() => next == null ? this : next!;
//
//   /// Return a new tile at ([row], [col]) with value [value].
//   static Tile create(int value, int col, int row) => Tile(value, col, row);
//
//   /// Return the result of moving me to ([col], [row]).
//   Tile move(int col, int row) {
//     final result = Tile(value, col, row);
//     next = result;
//     return result;
//   }
//
//   /// Return the result of merging [otherTile] with me after moving to
//   /// ([col], [row]).
//   Tile merge(int col, int row, Tile otherTile) {
//     assert(value == otherTile.value);
//     next = otherTile.next = Tile(2 * value, col, row);
//     return next!;
//   }
//
//   /// Return the distance in rows or columns between me and my successor
//   /// tile (0 if I have no successor).
//   int distToNext() {
//     if (next == null) {
//       return 0;
//     } else {
//       return max((row - next!.row).abs(), (col - next!.col).abs());
//     }
//   }
//
//   @override
//   String toString() => '$value@($col, $row)';
//
//   /// My value.
//   final int value;
//
//   /// My last position on the board.
//   final int row, col;
//
//   /// Successor tile: one I am moved to or merged with.
//   Tile? next;
// }
