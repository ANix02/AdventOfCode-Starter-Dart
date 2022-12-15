import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import '../utils/index.dart';

class Day14 extends GenericDay {
  Day14() : super(14);

  @override
  parseInput() {
    var result = input
        .getPerLine()
        .map((e) => e
            .split('->')
            .map((e) =>
                Point(int.parse(e.split(',')[0]), int.parse(e.split(',')[1])))
            .toList())
        .toList();
    var path = createPath(result);
    var deepestPoint =
        path.map((e) => e.y).sorted((a, b) => a.compareTo(b)).last;
    var leftPoint = path.map((e) => e.x).sorted((a, b) => a.compareTo(b)).first;
    var rightPoint = path.map((e) => e.x).sorted((a, b) => a.compareTo(b)).last;

    for (var i = leftPoint - 2000; i < rightPoint + 2000; i++) {
      path.add(Point(i, deepestPoint + 2));
    }
    printPath(path);
    print(fallingSand(path));
  }

  int fallingSand(Set<Point<int>> path) {
    Map<Point, String> sand = {};
    Point startingPoint = Point(500, 0);
    var deepestPoint =
        path.map((e) => e.y).sorted((a, b) => a.compareTo(b)).last;
    print(deepestPoint);
    var curPoint = startingPoint;
    bool goOn = true;
    int count = 0;
    while (goOn) {
      curPoint = startingPoint;
      while (checkIfFree(curPoint, sand, path)) {
        if (!((path.contains(Point(curPoint.x, curPoint.y + 1))) ||
            (sand.containsKey(Point(curPoint.x, curPoint.y + 1))))) {
          curPoint = Point(curPoint.x, curPoint.y + 1);
          // if (curPoint.y > deepestPoint + 2) {
          //   // goOn = false;
          //   break;
          // }
        } else if (!((path.contains(Point(curPoint.x - 1, curPoint.y + 1))) ||
            (sand.containsKey(Point(curPoint.x - 1, curPoint.y + 1))))) {
          curPoint = Point(curPoint.x - 1, curPoint.y + 1);
          //debug

        } else {
          curPoint = Point(curPoint.x + 1, curPoint.y + 1);
        }
      }

      if (goOn) {
        count += 1;
        print(count);
        sand.addAll({Point(curPoint.x, curPoint.y): 'o'});
        if ((curPoint.x == 500) && (curPoint.y == 0)) {
          goOn = false;
        }
      }
    }
    int result = 0;
    sand.forEach((key, value) {
      if (value == 'o') {
        result += 1;
      }
    });
    return result;
  }

  bool checkIfFree(
      Point curPoint, Map<Point, String> sand, Set<Point<int>> path) {
    bool free = false;
    // var deepestPoint =
    //     path.map((e) => e.y).sorted((a, b) => a.compareTo(b)).last;
    // if ((curPoint.y) == (deepestPoint + 2)) {
    //   return false;
    // }
    if (!((path.contains(Point(curPoint.x, curPoint.y + 1))) ||
        (sand.containsKey(Point(curPoint.x, curPoint.y + 1))))) {
      free = true;
    } else if (!((path.contains(Point(curPoint.x - 1, curPoint.y + 1))) ||
        (sand.containsKey(Point(curPoint.x - 1, curPoint.y + 1))))) {
      free = true;
    } else if (!((path.contains(Point(curPoint.x + 1, curPoint.y + 1))) ||
        (sand.containsKey(Point(curPoint.x + 1, curPoint.y + 1))))) {
      free = true;
    } else {
      free = false;
    }

    return free;
  }

  Set<Point<int>> createPath(List<List<Point<int>>> input) {
    Set<Point<int>> result = {};
    for (var line in input) {
      for (var i = 0; i < line.length; i++) {
        if (i == 0) {
          result.add(line[i]);
        } else {
          if (line[i].x - line[i - 1].x != 0) {
            var mover = (line[i].x - line[i - 1].x) ~/
                (line[i].x - line[i - 1].x).abs();
            var curX = line[i - 1].x;
            while (curX != line[i].x) {
              curX += mover;
              result.add(Point(curX, line[i].y));
            }
          } else {
            var mover = (line[i].y - line[i - 1].y) ~/
                (line[i].y - line[i - 1].y).abs();
            var curY = line[i - 1].y;
            while (curY != line[i].y) {
              curY += mover;
              result.add(Point(line[i].x, curY));
            }
          }
        }
      }
    }

    return result;
  }

  void printPath(Set<Point<int>> path) {
    var deepestPoint =
        path.map((e) => e.y).sorted((a, b) => a.compareTo(b)).last;
    var leftPoint = path.map((e) => e.x).sorted((a, b) => a.compareTo(b)).first;
    var rightPoint = path.map((e) => e.x).sorted((a, b) => a.compareTo(b)).last;
    print(leftPoint);
    for (var i = 0; i <= deepestPoint; i++) {
      for (var j = leftPoint; j <= rightPoint; j++) {
        if (path.contains(Point(j, i))) {
          stdout.write('#');
        } else {
          stdout.write('.');
        }
      }
      stdout.write('\n');
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
