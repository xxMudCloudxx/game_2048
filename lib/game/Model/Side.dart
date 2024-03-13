/// Symbolic names for the four sides of a board.
enum Side {
  NORTH, EAST, SOUTH, WEST
}

extension SideExtension on Side {
  /// Returns the side opposite of [s].
  // void setViewingPerspective(Side s, List grid) {
  //   switch (s) {
  //     case Side.EAST:
  //       rotate90Clockwise(grid);
  //       break;
  //     case Side.SOUTH:
  //       rotate180(grid);
  //       break;
  //     case Side.WEST:
  //       rotate90Counterclockwise(grid);
  //       break;
  //     default:
  //       break;
  //   }
  // }
  //
  // void rotate90Clockwise(List grid) {
  //   final List newGrid = List.generate(grid.first.length, (index) => List.filled(grid.length, null));
  //   for (var i = 0; i < grid.length; i++) {
  //     for (var j = 0; j < grid[i].length; j++) {
  //       newGrid[j][grid.length - 1 - i] = grid[i][j];
  //     }
  //   }
  //   grid = newGrid;
  // }
  //
  // void rotate180(List grid) {
  //   rotate90Clockwise(grid);
  //   rotate90Clockwise(grid);
  // }
  //
  // void rotate90Counterclockwise(List grid) {
  //   final List newGrid = List.generate(grid.first.length, (index) => List.filled(grid.length, null));
  //   for (var i = 0; i < grid.length; i++) {
  //     for (var j = 0; j < grid[i].length; j++) {
  //       newGrid[grid.length - 1 - j][i] = grid[i][j];
  //     }
  //   }
  //   grid = newGrid;
  // Side opposite() {
  //   switch (this) {
  //     case Side.NORTH:
  //       return Side.SOUTH;
  //     case Side.SOUTH:
  //       return Side.NORTH;
  //     case Side.EAST:
  //       return Side.WEST;
  //     case Side.WEST:
  //       return Side.EAST;
  //     default:
  //       throw Exception('Invalid side: $this');
  //   }
  // }
  //
  //
  //
  // /// Return the standard column number for square (C, R) on a board
  // /// of size [size] oriented with this [Side] on top.
  // int col(int c, int r, int size) {
  //   return col0Cast() * (size - 1) + c * drowCast() + r * dcol0Cast();
  // }
  //
  // /// Return the standard row number for square (C, R) on a board
  // /// of size [size] oriented with this [Side] on top.
  // int row(int c, int r, int size) {
  //   return row0Cast() * (size - 1) - c * dcol0Cast() + r * drowCast();
  // }
  //
  // int col0Cast() {
  //   switch (this) {
  //     case Side.NORTH:
  //       return 0;
  //     case Side.EAST:
  //       return 0;
  //     case Side.SOUTH:
  //       return 1;
  //     case Side.WEST:
  //       return 1;
  //     default:
  //       throw Exception('Invalid side: $this');
  //   }
  // }
  // int row0Cast() {
  //   switch (this) {
  //     case Side.NORTH:
  //       return 0;
  //     case Side.EAST:
  //       return 1;
  //     case Side.SOUTH:
  //       return 1;
  //     case Side.WEST:
  //       return 0;
  //     default:
  //       throw Exception('Invalid side: $this');
  //   }
  // }
  // int dcol0Cast() {
  //   switch (this) {
  //     case Side.NORTH:
  //       return 0;
  //     case Side.EAST:
  //       return 1;
  //     case Side.SOUTH:
  //       return 0;
  //     case Side.WEST:
  //       return -1;
  //     default:
  //       throw Exception('Invalid side: $this');
  //   }
  // }
  // int drowCast() {
  //   switch (this) {
  //     case Side.NORTH:
  //       return 1;
  //     case Side.EAST:
  //       return 0;
  //     case Side.SOUTH:
  //       return -1;
  //     case Side.WEST:
  //       return 0;
  //     default:
  //       throw Exception('Invalid side: $this');
  //   }
  // }

}