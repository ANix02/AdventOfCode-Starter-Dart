import 'dart:collection';

import 'package:more/tuple.dart' as tup;

import '../utils/index.dart';

import 'dart:math';
import 'package:more/more.dart';

var dirs = {
  'R': Point(1, 0),
  'L': Point(-1, 0),
  'U': Point(0, 1),
  'D': Point(0, -1)
};

countMoves(List<String> lines, {length = 2}) {
  var chain = List.generate(length, (index) => Point(0, 0));
  var seen = {chain.last};

  moveSegment(int ix) {
    var delta = chain[ix - 1] - chain[ix];
    if (delta.x.abs() <= 1 && delta.y.abs() <= 1) return;
    chain[ix] += Point(delta.x.sign, delta.y.sign);
  }

  for (var m in lines) {
    var ps = m.split(' ');
    for (var _ in 0.to(int.parse(ps.last))) {
      chain[0] += dirs[ps.first]!;
      1.to(chain.length).forEach(moveSegment);
      seen.add(chain.last);
    }
  }
  // for (var element in seen) {
  //   print('${element.x} : ${element.y}');
  // }
  return seen.length;
}

part1(List<String> lines) => countMoves(lines);

part2(List<String> lines) => countMoves(lines, length: 10);

class Pair {
  int col;
  int row;

  Pair(this.col, this.row);

  void calcNewPos(String direction) {
    switch (direction) {
      case 'U':
        col -= 1;
        break;
      case 'D':
        col += 1;
        break;
      case 'L':
        row -= 1;
        break;
      case 'R':
        row += 1;
        break;
      default:
        break;
    }
  }
}

class Day09 extends GenericDay {
  Day09() : super(9);

  @override
  parseInput() {
    // var head = Pair(0, 0);

    // var tail = Pair(head.col, head.row);
    List<Pair> pairList = [];
    for (var i = 0; i < 2; i++) {
      pairList.add(Pair(0, 0));
    }
    print(pairList.length);

    List<Pair> trackedSteps = [];
    trackedSteps.add(Pair(pairList.last.col, pairList.last.row));

    var lines = input
        .getPerLine()
        .map((e) => e.split(' ').map((e) => e).toList())
        .toList();
    print(part2(input.getPerLine()));
    // print(lines.length);

    for (var line in lines) {
      for (var i = 0; i < int.parse(line[1]); i++) {
        // print('New Line:');
        // for (var element in pairList) {
        //   print(' ${element.col} : ${element.row}}');
        // }
        // print('Before Head: ${head.col} . ${head.row}');
        // print('Before Tail: ${tail.col} . ${tail.row}');
        pairList.first.calcNewPos(line[0]);

        for (var j = 0; j < (pairList.length - 1); j++) {
          if (((pairList[j].col - pairList[j + 1].col).abs() +
                  (pairList[j].row - pairList[j + 1].row).abs()) >
              2) {
            if ((pairList[j].col - pairList[j + 1].col).abs() == 2) {
              pairList[j + 1].col +=
                  (pairList[j].col - pairList[j + 1].col).isNegative ? -1 : 1;
              pairList[j + 1].row +=
                  (pairList[j].row - pairList[j + 1].row).isNegative ? -1 : 1;
            } else {
              pairList[j + 1].row +=
                  (pairList[j].row - pairList[j + 1].row).isNegative ? -1 : 1;
              pairList[j + 1].col +=
                  (pairList[j].col - pairList[j + 1].col).isNegative ? -1 : 1;
            }
          } else {
            if ((pairList[j].col - pairList[j + 1].col).abs() == 2) {
              pairList[j + 1].col +=
                  (pairList[j].col - pairList[j + 1].col) ~/ 2;
            } else if ((pairList[j].row - pairList[j + 1].row).abs() == 2) {
              pairList[j + 1].row +=
                  (pairList[j].row - pairList[j + 1].row) ~/ 2;
            }
            // print('After Head: ${head.col} . ${head.row}');
            // print('After Tail: ${tail.col} . ${tail.row}');

          }
          var alreadyExists = false;
          for (var element in trackedSteps) {
            // print('${element.col} . ${element.row}');
            // print('${tail.col} . ${tail.row}');
            if ((element.col == pairList.last.col) &&
                (element.row == pairList.last.row)) {
              // print('(${element.col},${element.row})');
              // print('(${tail.col},${tail.row})');
              alreadyExists = true;
            }
          }
          if (!alreadyExists) {
            trackedSteps.add(Pair(pairList.last.col, pairList.last.row));
          }
        }
      }
    }
    for (var element in trackedSteps) {
      print('(${element.col},${element.row})');
    }

    print(trackedSteps.length);
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
