import '../utils/index.dart';
import 'package:collection/collection.dart';
import 'package:more/more.dart';

enum Origin { left, right, top, bottom }

class Tree {
  final int name;
  bool? top;
  bool? bottom;
  bool? left;
  bool? right;
  late final int scenicScore;

  Tree(this.name, this.top, this.bottom, this.left, this.right);
}

class Day08 extends GenericDay {
  Day08() : super(8);

  /// map all lines e then split them at ('') and map the list
  List<List<Tree>> readTrees(List<String> lines) => lines
      .map((e) => e
          .split('')
          .map((e) => Tree(int.parse(e), null, null, null, null))
          .toList())
      .toList();

  @override
  parseInput() {
    var lines = input.getPerLine();
    var trees = readTrees(lines);

    setVisible(trees);
    print(countVisible(trees));

    countScenicScore(trees);
    print(findHighestScenicScore(trees));
  }

  void setVisible(List<List<Tree>> trees) {
    /// links nach rechts nach unten
    for (var i = 0; i < trees.length; i++) {
      int highestValue = -1;
      for (var j = 0; j < trees[i].length; j++) {
        if (trees[i][j].name > highestValue) {
          highestValue = trees[i][j].name;
          trees[i][j].left = true;
        } else {
          trees[i][j].left = false;
        }
      }
    }

    /// oben nach unten nach rechts
    for (var j = 0; j < trees[0].length; j++) {
      int highestValue = -1;
      for (var i = 0; i < trees.length; i++) {
        if (trees[i][j].name > highestValue) {
          highestValue = trees[i][j].name;
          trees[i][j].top = true;
        } else {
          trees[i][j].top = false;
        }
      }
    }

    /// rechts nach links nach oben
    for (var i = trees.length - 1; i >= 0; i--) {
      int highestValue = -1;
      for (var j = trees[i].length - 1; j >= 0; j--) {
        if (trees[i][j].name > highestValue) {
          highestValue = trees[i][j].name;
          trees[i][j].right = true;
        } else {
          trees[i][j].right = false;
        }
      }
    }

    /// unten nach oben nach links
    for (var j = trees[0].length - 1; j >= 0; j--) {
      int highestValue = -1;
      for (var i = trees.length - 1; i >= 0; i--) {
        if (trees[i][j].name > highestValue) {
          highestValue = trees[i][j].name;
          trees[i][j].bottom = true;
        } else {
          trees[i][j].bottom = false;
        }
      }
    }
  }

  int countVisible(List<List<Tree>> trees) {
    int sum = 0;
    for (var line in trees) {
      for (var tree in line) {
        if (tree.bottom! || tree.left! || tree.right! || tree.top!) {
          sum += 1;
        }
      }
    }
    return sum;
  }

  void countScenicScore(List<List<Tree>> trees) {
    for (var i = 0; i < trees.length; i++) {
      for (var j = 0; j < trees[i].length; j++) {
        int left = 0, right = 0, top = 0, bottom = 0;

        // move to the left
        int s = j;
        while ((s - 1) >= 0) {
          s -= 1;
          if (trees[i][j].name > trees[i][s].name) {
            left += 1;
          } else {
            left += 1;
            break;
          }
        }

        // move to the right
        int t = j;
        while ((t + 1) < trees[i].length) {
          t += 1;
          if (trees[i][j].name > trees[i][t].name) {
            right += 1;
          } else {
            right += 1;
            break;
          }
        }

        // move to the top
        int u = i;
        while ((u - 1) >= 0) {
          u -= 1;
          if (trees[i][j].name > trees[u][j].name) {
            top += 1;
          } else {
            top += 1;
            break;
          }
        }

        // move to the bottom
        int v = i;
        while ((v + 1) < trees.length) {
          v += 1;
          if (trees[i][j].name > trees[v][j].name) {
            bottom += 1;
          } else {
            bottom += 1;
            break;
          }
        }

        trees[i][j].scenicScore = left * right * top * bottom;
      }
    }
  }

  int findHighestScenicScore(List<List<Tree>> trees) {
    int highestScore = 0;
    for (var line in trees) {
      for (var tree in line) {
        if (tree.scenicScore > highestScore) {
          highestScore = tree.scenicScore;
        }
      }
    }
    return highestScore;
  }

  // int setVisibility(
  //     List<List<Tree>> trees, int curPosHor, int curPosVer, Origin? origin) {
  //   if (curPosHor >= trees[0].length ||
  //       curPosVer >= trees.length ||
  //       curPosHor < 0 ||
  //       curPosVer < 0) {
  //     return 0;
  //   }
  //   if ((Origin.bottom == origin) &&
  //       (trees[curPosVer][curPosHor].bottom == null)) {
  //     var newMovement = addMovement(Origin.bottom, [curPosVer, curPosHor]);
  //     var newPosVer = newMovement[0], newPosHor = newMovement[1];
  //     var value = setVisibility(trees, newPosHor, newPosVer, origin);
  //     if (value) {
  //       if (newPosVer >= trees.length) {
  //         trees[curPosVer][curPosHor].bottom = true;
  //       } else if (trees[curPosVer][curPosHor].name >
  //           trees[newPosVer][newPosHor].name) {
  //         trees[curPosVer][curPosHor].bottom = true;
  //       }
  //     }
  //   }
  // }

  List<int> addMovement(Origin origin, List<int> oldPos) {
    switch (origin) {
      case Origin.bottom:
        return [oldPos[0] + 1, oldPos[1]];

      case Origin.top:
        return [oldPos[0] - 1, oldPos[1]];

      case Origin.left:
        return [oldPos[0], oldPos[1] - 1];

      case Origin.right:
        return [oldPos[0], oldPos[1] + 1];

      default:
        return [oldPos[0], oldPos[1]];
    }
  }

  @override
  int solvePart1() {
    parseInput();
    return 0;
  }

  @override
  int solvePart2() {
    return 0;
  }
}
