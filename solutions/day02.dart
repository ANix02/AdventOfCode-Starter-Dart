import '../utils/index.dart';

class Day02 extends GenericDay {
  Day02() : super(2);

  int calcSum(String opponent, String myself) {
    var sum = 1;

    if (myself.contains('Y')) sum += 1;

    if (myself.contains('Z')) sum += 2;

    if (opponent.contains('A') && myself.contains('X') ||
        opponent.contains('B') && myself.contains('Y') ||
        opponent.contains('C') && myself.contains('Z')) {
      sum += 3;
    } else if (opponent.contains('A') && myself.contains('Y') ||
        opponent.contains('B') && myself.contains('Z') ||
        opponent.contains('C') && myself.contains('X')) {
      sum += 6;
    }
    return sum;
  }

  int calcSum2(String opponent, String myself) {
    var sum = 1;
    switch (myself) {
      case 'X':
        if (opponent.contains('A')) {
          myself = 'Z';
        } else if (opponent.contains('C')) {
          myself = 'Y';
        }
        break;
      case 'Y':
        if (opponent.contains('A')) {
          myself = 'X';
        } else if (opponent.contains('C')) {
          myself = 'Z';
        }
        break;
      case 'Z':
        if (opponent.contains('A')) {
          myself = 'Y';
        } else if (opponent.contains('C')) {
          myself = 'X';
        }
        break;
      default:
    }

    if (myself.contains('Y')) sum += 1;

    if (myself.contains('Z')) sum += 2;

    if (opponent.contains('A') && myself.contains('X') ||
        opponent.contains('B') && myself.contains('Y') ||
        opponent.contains('C') && myself.contains('Z')) {
      sum += 3;
    } else if (opponent.contains('A') && myself.contains('Y') ||
        opponent.contains('B') && myself.contains('Z') ||
        opponent.contains('C') && myself.contains('X')) {
      sum += 6;
    }
    return sum;
  }

  @override
  parseInput() {
    var result = 0;
    var lines = input.getPerLine().map((e) => e.split(' '));

    lines = lines.whereNot((element) => element.isEmpty);
    lines.forEach((element) {
      if (element.first.isNotEmpty) {
        result += calcSum2(element.first, element.last);
      }
    });
    return result;
  }

  @override
  int solvePart1() {
    return parseInput();
  }

  @override
  int solvePart2() {
    return 0;
  }
}
