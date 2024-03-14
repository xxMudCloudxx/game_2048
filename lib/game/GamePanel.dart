import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/game/GameLogic.dart';
import 'package:game_2048/main.dart';
import 'package:provider/provider.dart';

import 'Color.dart';
import 'GameMap.dart';
import 'Model/Side.dart';
bool _noMoveInSwipe = true;

class GamePanel extends StatefulWidget {
  final ValueChanged<int>? onScoreChanged;

  GamePanel({Key? key, this.onScoreChanged}) : super(key: key);

  @override
  GamePanelState createState() => GamePanelState();
}

class GamePanelState extends State<GamePanel> {
  GamePanelState() {
    initState();
  }
  // 数据源，类型是 List<List<int>>
  static GameMap _gameMap = GameMap();
  GameLogic logic = GameLogic();

  /// 当上下滑动时，左右方向的偏移应该小于这个阈值，左右滑动亦然
  double _crossAxisMaxLimit = 20.0;

  /// 当上下滑动时，上下方向的偏移应该大于这个阈值，左右滑动亦然
  double _mainAxisMinLimit = 40.0;

  /// 每行每列的个数
  static const int SIZE = 4;

  /// 判断是否游戏结束
  static bool _isGameOver = false;

  bool _firstTouch = true;

  void checkEnd() {
    if(logic.gameOver(_gameMap)) {
      setState(() {
        _isGameOver = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isGameOver) {
      return Stack(
        children: [
          _buildGamePanel(context),
          _buildGameOverMask(context),
        ],
      );
    } else {
      return _buildGamePanel(context);
    }
  }

  void reStartGame() {
    logic.reset(_gameMap);
    Provider.of<Score>(context, listen: false).clear();
    Provider.of<Score>(context, listen: false).initGameMap();
    // 清空分数
    //Provider.of<Score>(context).clearScore();
    _isGameOver = false;
  }

  @override
  void initState() {
    setState(() {
      logic.reset(_gameMap);
      Provider.of<Score>(context, listen: false).clear();
      //Provider.of<Score>(context).clearScore();
      super.initState();
      Provider.of<Score>(context, listen: false).initGameMap();
    });
  }

  void NewGame() {
    setState(() {
      Provider.of<Score>(context, listen: false).currentScore = 0;
      Provider.of<Score>(context, listen: false).NewGame();
      _isGameOver = false;
    });
  }



  Widget _buildGamePanel(BuildContext context) {
    Offset lastPosition = Offset.zero;
    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        lastPosition = details.globalPosition;
        _firstTouch = true;
      },
      onPanUpdate: (details) {
        final curPosition = details.globalPosition;
        if ((curPosition.dx - lastPosition.dx).abs() > _mainAxisMinLimit &&
            (curPosition.dy - lastPosition.dy).abs() < _crossAxisMaxLimit) {
          // 水平
          if (_firstTouch) {
            _firstTouch = false;
            if ((curPosition.dx - lastPosition.dx).abs() > _crossAxisMaxLimit) {
              if(curPosition.dx - lastPosition.dx > 0) {
                setMoveState(Side.EAST);
              } else {
                // print("moveWest");
                // setMoveState(Side.WEST);
                print("moveSouth");
                setMoveState(Side.WEST);
              }
            }
          }
        } else if((curPosition.dy - lastPosition.dy).abs() >
            _mainAxisMinLimit &&
            (curPosition.dx - lastPosition.dx).abs() < _crossAxisMaxLimit){
          //垂直
          if ((curPosition.dy - lastPosition.dy).abs() > _mainAxisMinLimit) {
            if (_firstTouch) {
              _firstTouch = false;
              if(curPosition.dy - lastPosition.dy > 0) {
                // print("moveSouth");
                // setMoveState(Side.SOUTH);
                print("moveEast");
                setMoveState(Side.SOUTH);
              } else {
                // print("moveNORTH");
                // setMoveState(Side.NORTH);
                print("moveWest");
                setMoveState(Side.NORTH);
              }
            }
          }
        }

      },
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          child: _buildGameFrame(
              context,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  /// GridView 默认顶部会有 padding，通过这个删除顶部 padding
                  context: context,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    /// 禁用 GridView 的滑动
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SIZE,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: SIZE * SIZE,
                    itemBuilder: (context, int index) {
                      int indexI = index ~/ SIZE;
                      int indexJ = index % SIZE;
                      return _buildGameCell(Provider.of<Score>(context, listen: true).tile1(indexI, indexJ));
                    },
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  void setMoveState(Side side) {
    return setState(() {
      switch (side) {
        case Side.NORTH:
          _joinGameMapDataToTop();
          break;
        case Side.SOUTH:
          _joinGameMapDataToBottom();
          break;
        case Side.EAST:
          _joinGameMapDataToRight();
          break;
        case Side.WEST:
          _joinGameMapDataToLeft();
          break;
        default:
          throw Exception('Invalid side: $this');
      }
      if (!_noMoveInSwipe) {
        var a = Random().nextDouble();
        if (a < 0.75) Provider.of<Score>(context, listen: false).randomNewCellData(2);
        else Provider.of<Score>(context, listen: false).randomNewCellData(4);
      }
      checkEnd();
    });
  }



  /// GridView 中的子组件，表示每个小块
  Widget _buildGameCell(int value) {
    return Container(
      decoration: BoxDecoration(
        color: numTileColor[value],
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
            color: numTextColor[value],
            fontSize: 40
          ),
        ),
      ),
    );
  }

  /// 游戏结束时盖在 Panel 上的蒙层
  Widget _buildGameOverMask(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Game Over"),
              InkWell(
                  onTap: () {
                    reStartGame();
                  },
                  child: Text("ReStart"))
            ],
          ),
        ));
  }

  /// 创建一个 1 * 1 的游戏框架布局
  Widget _buildGameFrame(BuildContext context, Widget child) {
    double minSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: minSize,
        height: minSize,
        margin: EdgeInsets.all(10),
        child: child,
      ),
    );
  }

  void _joinGameMapDataToLeft() {
    _noMoveInSwipe = true;
    for (int i = 0; i < SIZE; i++) {
      int j1 = 0;
      while (j1 < SIZE - 1) {
        if (_gameMap.tile(i, j1) == 0) {
          j1++;
          continue;
        }
        for (int j2 = j1 + 1; j2 < SIZE; j2++) {
          if (_gameMap.tile(i, j2) == 0) {
            continue;
          } else if (_gameMap.tile(i, j2) != _gameMap.tile(i, j1)) {
            break;
          } else {
            _gameMap.retile(i, j1, 2 * _gameMap.tile(i, j1));
            _gameMap.retile(i, j2, 0);
            Provider.of<Score>(context, listen: false).setScore(_gameMap.tile(i, j1));

            j1 = j2;
            _noMoveInSwipe = false;
          }
        }
        j1++;
      }
      int notZeroCount = 0;
      for (int k = 0; k < SIZE; k++) {
        if (_gameMap.tile(i, k) != 0) {
          if (k != notZeroCount) {
            _gameMap.retile(i, notZeroCount, _gameMap.tile(i, k));
            _gameMap.retile(i, k, 0);
            _noMoveInSwipe = false;
          }
          notZeroCount++;
        }
      }
    }
  }

  void _joinGameMapDataToRight() {
    _noMoveInSwipe = true;
    for (int i = 0; i < SIZE; i++) {
      int j1 = SIZE - 1;
      while (j1 > 0) {
        if (_gameMap.tile(i, j1) == 0) {
          j1--;
          continue;
        }
        for (int j2 = j1 - 1; j2 >= 0; j2--) {
          if (_gameMap.tile(i, j2) == 0) {
            continue;
          } else if (_gameMap.tile(i, j2) != _gameMap.tile(i, j1)) {
            break;
          } else {
            _gameMap.retile(i, j1, 2 * _gameMap.tile(i, j1));
            _gameMap.retile(i, j2, 0);
            Provider.of<Score>(context, listen: false).setScore(_gameMap.tile(i, j1));
            j1 = j2;
            _noMoveInSwipe = false;
          }
        }
        j1--;
      }
      int notZeroCount = 0;
      for (int k = SIZE - 1; k >= 0; k--) {
        if (_gameMap.tile(i, k) != 0) {
          if (k != (SIZE - 1 - notZeroCount)) {
            _gameMap.retile(i, SIZE - 1 - notZeroCount, _gameMap.tile(i, k));
            _gameMap.retile(i, k, 0);
            _noMoveInSwipe = false;
          }
          notZeroCount++;
        }
      }
    }
  }

  void _joinGameMapDataToTop() {
    _noMoveInSwipe = true;
    for (int j = 0; j < SIZE; j++) {
      int i1 = 0;
      while (i1 < SIZE - 1) {
        if (_gameMap.tile(i1, j) == 0) {
          i1++;
          continue;
        }
        for (int i2 = i1 + 1; i2 < SIZE; i2++) {
          if (_gameMap.tile(i2, j) == 0) {
            continue;
          } else if (_gameMap.tile(i2, j) != _gameMap.tile(i1, j)) {
            break;
          } else {
            _gameMap.retile(i1, j, 2 * _gameMap.tile(i1, j));
            _gameMap.retile(i2, j, 0);
            Provider.of<Score>(context, listen: false).setScore(_gameMap.tile(i1, j));
            i1 = i2;
            _noMoveInSwipe = false;
          }
        }
        i1++;
      }
      int notZeroCount = 0;
      for (int k = 0; k < SIZE; k++) {
        if (_gameMap.tile(k, j) != 0) {
          if (k != notZeroCount) {
            _gameMap.retile(notZeroCount, j, _gameMap.tile(k, j));
            _gameMap.retile(k, j, 0);
            _noMoveInSwipe = false;
          }
          notZeroCount++;
        }
      }
    }
  }

  void _joinGameMapDataToBottom() {
    _noMoveInSwipe = true;
    for (int j = 0; j < SIZE; j++) {
      int i1 = SIZE - 1;
      while (i1 > 0) {
        if (_gameMap.tile(i1, j) == 0) {
          i1--;
          continue;
        }
        for (int i2 = i1 - 1; i2 >= 0; i2--) {
          if (_gameMap.tile(i2, j) == 0) {
            continue;
          } else if (_gameMap.tile(i2, j) != _gameMap.tile(i1, j)) {
            break;
          } else {
            _gameMap.retile(i1, j, 2 * _gameMap.tile(i1, j));
            _gameMap.retile(i2, j, 0);
            Provider.of<Score>(context, listen: false).setScore(_gameMap.tile(i1, j));
            i1 = i2;
            _noMoveInSwipe = false;
          }
        }
        i1--;
      }
      int notZeroCount = 0;
      for (int k = SIZE - 1; k >= 0; k--) {
        if (_gameMap.tile(k, j) != 0) {
          if (k != (SIZE - 1 - notZeroCount)) {
            _gameMap.retile(SIZE - 1 - notZeroCount, j, _gameMap.tile(k, j));
            _gameMap.retile(k, j, 0);
            _noMoveInSwipe = false;
          }
          notZeroCount++;
        }
      }
    }
  }


// bool tilt(Side side) {
  //   print("tilt work");
  //   bool changed;
  //   changed = false;
  //
  //   // TODO: Modify this._gameMap (and perhaps this.score) to account
  //   // for the tilt to the Side SIDE. If the _gameMap changed, set the
  //   // changed local variable to true.
  //   _gameMap.setViewingPerspective(side);
  //
  //   for (int c = 0; c < _gameMap.size(); c++){
  //     for(int r = _gameMap.size()-1; r >= 0; r--){
  //       int t = _gameMap.tile(c, r);
  //       int row = r;
  //       if(_gameMap.tile(c, r) != 0){
  //         for(int i = _gameMap.size()-1; i > r; i--){
  //           if (_gameMap.tile(c, i) == 0) {
  //             setState(()=> _gameMap.move( c, i, c, r));
  //             row = i;
  //             changed = true;
  //             break;
  //           }
  //         }
  //         for (int i = row -1; i >= 0; i--){
  //           if(_gameMap.tile(c, i)!=0 && t != _gameMap.tile(c, i)) {
  //             break;
  //           } else if(_gameMap.tile(c, i)!= 0 && t == _gameMap.tile(c, i)){
  //             setState(() =>_gameMap.move(c, row, c, i));
  //             changed = true;
  //             logic.currentScore += _gameMap.tile(c, row);
  //             break;
  //           }
  //         }
  //       }
  //     }
  //   }
  //  _gameMap.setViewingPerspective(Side.NORTH);
  //   checkEnd();
  //   if (changed) {
  //     setState(() {
  //       _noMoveInSwipe = true;
  //     });
  //   } else {
  //     setState(() => _noMoveInSwipe = false);
  //   }
  //   return changed;
  // }
  //
}