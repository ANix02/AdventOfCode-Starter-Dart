import '../utils/index.dart';
import 'dart:io';

class Day12 extends GenericDay {
  Day12() : super(12);

  var yBorders = [];
  var xBorders = [];
  var elevationLevel = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  var specialElevationLevel = {'S': 'a', 'E': 'z'};

  @override
  parseInput() {
    var map = input.getPerLine().map((e) => e.split('')).toList();
    for (var line in map) {
      for (var element in line) {
        stdout.write(element);
      }
      stdout.write('\n');
    }

    var startingPosition = <String, int>{'y': 0, 'x': 20};
    yBorders = [0, map[0].length - 1];
    xBorders = [0, map.length - 1];
    print(map[0].length - 1);
    print(map[startingPosition['x']!][startingPosition['y']!]);
    print(calcBestPath(startingPosition['x']!, startingPosition['y']!,
        startingPosition['x']!, startingPosition['y']!, map));
  }

  int calcBestPath(
      int oldX, int oldY, int curX, int curY, List<List<String>> map) {
    print(curY);
    if (map[curX][curY] == 'E') {
      return 1;
    }
    var result = 0;
    var sum = <int>[0, 0, 0, 0];
    for (var i = 0; i < 4; i++) {
      switch (i) {
        case 0: // nach oben
          var newX = curX;
          newX -= 1;
          if (oldX == newX && oldY == curY) {
            sum[i] = 9999999;
            break;
          }
          if (newX < xBorders[0]) {
            sum[i] = 9999999;
          } else if (!checkElevation(curX, curY, newX, curY, map)) {
            sum[i] = 9999999;
          } else {
            sum[i] = calcBestPath(curX, curY, newX, curY, map);
          }
          break;
        case 1: // nach rechts
          var newY = curY;
          newY += 1;
          if (oldX == curX && oldY == newY) {
            sum[i] = 9999999;
            break;
          }
          if (newY > yBorders[1]) {
            sum[i] = 9999999;
          } else if (!checkElevation(curX, curY, curX, newY, map)) {
            sum[i] = 9999999;
          } else {
            sum[i] = calcBestPath(curX, curY, curX, newY, map);
          }
          break;
        case 2: // nach unten
          var newX = curX;
          newX += 1;
          if (oldX == newX && oldY == curY) {
            sum[i] = 9999999;
            break;
          }
          if (newX > xBorders[1]) {
            sum[i] = 9999999;
          } else if (!checkElevation(curX, curY, newX, curY, map)) {
            sum[i] = 9999999;
          } else {
            sum[i] = calcBestPath(curX, curY, newX, curY, map);
          }
          break;
        case 3: // nach links
          var newY = curY;
          newY -= 1;
          if (oldX == curX && oldY == newY) {
            sum[i] = 9999999;
            break;
          }
          if (newY < yBorders[0]) {
            sum[i] = 9999999;
          } else if (!checkElevation(curX, curY, curX, newY, map)) {
            sum[i] = 9999999;
          } else {
            sum[i] = calcBestPath(curX, curY, curX, newY, map);
          }
          break;
        default:
          break;
      }
    }
    result = sum.map((e) => e).toList().sorted((a, b) => b.compareTo(a)).first;

    return 1 + result;
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

  bool checkElevation(
      int oldX, int oldY, int newX, int newY, List<List<String>> map) {
    var oldElevation = map[oldX][oldY];
    var newElevation = map[newX][newY];
    if (specialElevationLevel.containsKey(oldElevation)) {
      oldElevation = specialElevationLevel[oldElevation]!;
    }
    if (specialElevationLevel.containsKey(newElevation)) {
      newElevation = specialElevationLevel[newElevation]!;
    }
    var result = false;
    if ((elevationLevel[elevationLevel
                    .indexWhere((element) => element == oldElevation) +
                1] ==
            newElevation) ||
        (elevationLevel[elevationLevel
                .indexWhere((element) => element == oldElevation)] ==
            newElevation) ||
        (elevationLevel.indexWhere((element) => element == oldElevation) <
            (elevationLevel
                .indexWhere((element) => element == newElevation)))) {
      result = true;
    }
    return result;
  }
}
