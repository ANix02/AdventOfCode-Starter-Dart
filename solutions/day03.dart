import '../utils/index.dart';

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  List<List<String>> parseInput() {
    final result = input.getPerLine().map((e) => e.split('')).toList();
    return result;
  }

  @override
  int solvePart1() {
    int sum = 0;
    final List<String> notSymbol = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '.',
    ];

    final input = parseInput();

    for (var y = 0; y < input.length; y++) {
      for (var x = 0; x < input[0].length; x++) {
        var amountPositions = 0;
        var textNumber = '';
        var success = false;
        var result = 0;
        while (int.tryParse(input[y][x + amountPositions]) != null) {
          // ignore: use_string_buffers
          textNumber += input[y][x + amountPositions];
          amountPositions++;
          if (x + amountPositions >= input[0].length) {
            break;
          }
        }

        for (var i = 0; i < amountPositions; i++) {
          if (checkAround(input, y, x + i, notSymbol)) {
            success = true;
            break;
          }
        }
        if (amountPositions > 0) {
          result = int.parse(textNumber);
          x += amountPositions - 1;
        }
        if (success) {
          sum += result;
        }
      }
    }
    return sum;
  }

  @override
  int solvePart2() {
    var sum = 0;
    List<List<NumberSet>> numberSets = [];
    final List<String> number = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
    ];

    final input = parseInput();
    for (var y = 0; y < input.length; y++) {
      for (var x = 0; x < input[0].length; x++) {
        if (input[y][x] == '*') {
          final newNumberSet = checkAroundPart2(input, y, x, number);
          if (newNumberSet.length == 2) {
            numberSets.add(newNumberSet);
          }
        }
      }
    }
    for (final element in numberSets) {
      sum += element[0].number * element[1].number;
    }
    return sum;
  }

  bool checkAround(List<List<String>> schematic, int curYPos, int curXPos,
      List<String> notSymbol) {
    final maxXPos = schematic[0].length - 1;
    final maxYPos = schematic.length - 1;

    if (curXPos > 0) {
      if (!notSymbol.contains(schematic[curYPos][curXPos - 1])) {
        return true;
      }
      if (curYPos > 0) {
        if (!notSymbol.contains(schematic[curYPos - 1][curXPos - 1])) {
          return true;
        }
      }
      if (curYPos < maxYPos) {
        if (!notSymbol.contains(schematic[curYPos + 1][curXPos - 1])) {
          return true;
        }
      }
    }
    if (curXPos < maxXPos) {
      if (!notSymbol.contains(schematic[curYPos][curXPos + 1])) {
        return true;
      }
      if (curYPos > 0) {
        if (!notSymbol.contains(schematic[curYPos - 1][curXPos + 1])) {
          return true;
        }
      }
      if (curYPos < maxYPos) {
        if (!notSymbol.contains(schematic[curYPos + 1][curXPos + 1])) {
          return true;
        }
      }
    }
    if (curYPos > 0) {
      if (!notSymbol.contains(schematic[curYPos - 1][curXPos])) {
        return true;
      }
    }
    if (curYPos < maxYPos) {
      if (!notSymbol.contains(schematic[curYPos + 1][curXPos])) {
        return true;
      }
    }
    return false;
  }

  List<NumberSet> checkAroundPart2(List<List<String>> schematic, int curYPos,
      int curXPos, List<String> numbers) {
    final maxXPos = schematic[0].length - 1;
    final maxYPos = schematic.length - 1;
    var numberSets = <NumberSet>[];

    if (curXPos > 0) {
      if (numbers.contains(schematic[curYPos][curXPos - 1])) {
        final newNumberSet = createNumberSet(schematic, curYPos, curXPos - 1);
        var alreadyExists = false;
        for (final numberSet in numberSets) {
          if (numberSet.isEqual(newNumberSet)) {
            alreadyExists = true;
          }
        }
        if (!alreadyExists) {
          numberSets.add(newNumberSet);
        }
      }
      if (curYPos > 0) {
        if (numbers.contains(schematic[curYPos - 1][curXPos - 1])) {
          final newNumberSet =
              createNumberSet(schematic, curYPos - 1, curXPos - 1);
          var alreadyExists = false;
          for (final numberSet in numberSets) {
            if (numberSet.isEqual(newNumberSet)) {
              alreadyExists = true;
            }
          }
          if (!alreadyExists) {
            numberSets.add(newNumberSet);
          }
        }
      }
      if (curYPos < maxYPos) {
        if (numbers.contains(schematic[curYPos + 1][curXPos - 1])) {
          final newNumberSet =
              createNumberSet(schematic, curYPos + 1, curXPos - 1);
          var alreadyExists = false;
          for (final numberSet in numberSets) {
            if (numberSet.isEqual(newNumberSet)) {
              alreadyExists = true;
            }
          }
          if (!alreadyExists) {
            numberSets.add(newNumberSet);
          }
        }
      }
    }
    if (curXPos < maxXPos) {
      if (numbers.contains(schematic[curYPos][curXPos + 1])) {
        final newNumberSet = createNumberSet(schematic, curYPos, curXPos + 1);
        var alreadyExists = false;
        for (final numberSet in numberSets) {
          if (numberSet.isEqual(newNumberSet)) {
            alreadyExists = true;
          }
        }
        if (!alreadyExists) {
          numberSets.add(newNumberSet);
        }
      }
      if (curYPos > 0) {
        if (numbers.contains(schematic[curYPos - 1][curXPos + 1])) {
          final newNumberSet =
              createNumberSet(schematic, curYPos - 1, curXPos + 1);
          var alreadyExists = false;
          for (final numberSet in numberSets) {
            if (numberSet.isEqual(newNumberSet)) {
              alreadyExists = true;
            }
          }
          if (!alreadyExists) {
            numberSets.add(newNumberSet);
          }
        }
      }
      if (curYPos < maxYPos) {
        if (numbers.contains(schematic[curYPos + 1][curXPos + 1])) {
          final newNumberSet =
              createNumberSet(schematic, curYPos + 1, curXPos + 1);
          var alreadyExists = false;
          for (final numberSet in numberSets) {
            if (numberSet.isEqual(newNumberSet)) {
              alreadyExists = true;
            }
          }
          if (!alreadyExists) {
            numberSets.add(newNumberSet);
          }
        }
      }
    }
    if (curYPos > 0) {
      if (numbers.contains(schematic[curYPos - 1][curXPos])) {
        final newNumberSet = createNumberSet(schematic, curYPos - 1, curXPos);
        var alreadyExists = false;
        for (final numberSet in numberSets) {
          if (numberSet.isEqual(newNumberSet)) {
            alreadyExists = true;
          }
        }
        if (!alreadyExists) {
          numberSets.add(newNumberSet);
        }
      }
    }
    if (curYPos < maxYPos) {
      if (numbers.contains(schematic[curYPos + 1][curXPos])) {
        final newNumberSet = createNumberSet(schematic, curYPos + 1, curXPos);
        var alreadyExists = false;
        for (final numberSet in numberSets) {
          if (numberSet.isEqual(newNumberSet)) {
            alreadyExists = true;
          }
        }
        if (!alreadyExists) {
          numberSets.add(newNumberSet);
        }
      }
    }
    return numberSets;
  }

  NumberSet createNumberSet(
    List<List<String>> schematic,
    int curYPos,
    int curXPos,
  ) {
    int startYPos = curYPos;
    int startXPos = curXPos;
    int endYPos = curYPos;
    int endXPos = curXPos;
    int number;

    while (true) {
      if (startXPos - 1 < 0) {
        break;
      }
      if (int.tryParse(schematic[startYPos][startXPos - 1]) != null) {
        startXPos--;
      } else {
        break;
      }
    }
    while (true) {
      if (endXPos + 1 >= schematic[0].length) {
        break;
      }
      if (int.tryParse(schematic[endYPos][endXPos + 1]) != null) {
        endXPos++;
      } else {
        break;
      }
    }

    var textNumber = '';
    for (var x = startXPos; x <= endXPos; x++) {
      // ignore: use_string_buffers
      textNumber += schematic[curYPos][x];
    }
    number = int.parse(textNumber);
    return NumberSet(
      startX: startXPos,
      startY: startYPos,
      endX: endXPos,
      endY: endYPos,
      number: number,
    );
  }
}

class NumberSet {
  NumberSet({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.number,
  });
  int startX;
  int startY;
  int endX;
  int endY;
  int number;

  bool isEqual(NumberSet other) {
    return startX == other.startX &&
        startY == other.startY &&
        endX == other.endX &&
        endY == other.endY &&
        number == other.number;
  }
}
