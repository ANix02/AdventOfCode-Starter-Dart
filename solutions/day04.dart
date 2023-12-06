import 'dart:math';

import '../utils/index.dart';

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  List<List<List<int>>> parseInput() {
    final lines = input
        .getPerLine()
        .map((e) => e.substring(e.indexOf(':') + 1))
        .map((e) => e.split('|'))
        .map(getNumbers)
        .toList();
    return lines;
  }

  List<List<int>> getNumbers(List<String> lines) {
    List<List<int>> numbers = [];

    for (final line in lines) {
      List<int> firstLine = [];
      line.trimLeft();
      var numberFound = false;
      var j = 0;
      for (var i = 0; i < line.length; i++) {
        if (line[i] != ' ') {
          if (!numberFound) {
            j = i;
            numberFound = true;
          } else {}
        } else if (numberFound) {
          firstLine.add(int.parse(line.substring(j, i)));
          numberFound = false;
        }
      }
      if (numberFound) {
        firstLine.add(int.parse(line.substring(j, line.length)));
      }
      numbers.add(firstLine);
    }
    return numbers;
  }

  @override
  int solvePart1() {
    final input = parseInput();
    int sum = 0;
    for (var line in input) {
      int totalAmount = line[0].length + line[1].length;
      var combinedLine = line[0] + line[1];
      Set<int> uniqueNumbers = Set<int>();
      uniqueNumbers.addAll(combinedLine);
      final diff = totalAmount - uniqueNumbers.length;
      if (diff > 0) {
        sum += pow(2, diff - 1).toInt();
      }
    }
    return sum;
  }

  @override
  int solvePart2() {
    final input = parseInput();
    return recurseWinningCards(0, input, input.length);
  }

  int recurseWinningCards(
      int curIndex, List<List<List<int>>> input, int steps) {
    var sum = 0;
    for (var i = 0; i < steps; i++) {
      final totalAmount =
          input[curIndex + i][0].length + input[curIndex + i][1].length;
      final combinedLine = input[curIndex + i][0] + input[curIndex + i][1];
      final newUniqueNumbers = <int>{}..addAll(combinedLine);
      final diff = totalAmount - newUniqueNumbers.length;
      sum += 1;
      if (diff == 0) {
      } else {
        if (curIndex + 1 >= input.length) {
        } else {
          sum += recurseWinningCards(curIndex + i + 1, input, diff);
        }
      }
    }
    return sum;
  }
}
