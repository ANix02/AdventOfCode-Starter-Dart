import '../utils/index.dart';

enum Configuration {
  red(12),
  green(13),
  blue(14);

  const Configuration(this.amount);

  final int amount;
}

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<List<List<String>>> parseInput() {
    var result = input.getPerLine();
    List<String> modifiedResult = [];
    for (var element in result) {
      final pos = element.indexOf(':');
      modifiedResult.add(element.substring(pos + 1));
    }

    var list = modifiedResult
        .map((e) => e.split(';').map((e) => e.split(',')).toList())
        .toList();
    return list;
  }

  @override
  int solvePart1() {
    final result = parseInput();
    int sum = 0;
    for (var i = 1; i <= result.length; i++) {
      bool valid = true;

      for (var j = 0; j < result[i - 1].length; j++) {
        var red = 0;
        var green = 0;
        var blue = 0;
        // print('Game: $i\n');

        for (final element in result[i - 1][j]) {
          // print(element);
          final draw = element.trimLeft().split(' ');
          switch (draw[1]) {
            case 'red':
              red += int.parse(draw[0]);
            case 'green':
              green += int.parse(draw[0]);
            case 'blue':
              blue += int.parse(draw[0]);
          }
        }
        if (!checkIfValid(red, green, blue)) {
          valid = false;
        }

        print('red: $red, blue: $blue, green: $green, $valid');
      }
      print('Game: $i\n $valid');
      if (valid) {
        sum += i;
      }
    }

    return sum;
  }

  @override
  int solvePart2() {
    final result = parseInput();
    int sum = 0;
    for (var i = 1; i <= result.length; i++) {
      bool valid = true;
      var maxRed = 0;
      var maxGreen = 0;
      var maxBlue = 0;
      for (var j = 0; j < result[i - 1].length; j++) {
        var red = 0;
        var green = 0;
        var blue = 0;
        // print('Game: $i\n');

        for (final element in result[i - 1][j]) {
          // print(element);
          final draw = element.trimLeft().split(' ');
          switch (draw[1]) {
            case 'red':
              red += int.parse(draw[0]);
            case 'green':
              green += int.parse(draw[0]);
            case 'blue':
              blue += int.parse(draw[0]);
          }
        }
        if (!checkIfValid(red, green, blue)) {
          valid = false;
        }
        if (maxRed < red) {
          maxRed = red;
        }

        if (maxGreen < green) {
          maxGreen = green;
        }

        if (maxBlue < blue) {
          maxBlue = blue;
        }

        print('red: $red, blue: $blue, green: $green, $valid');
      }
      print('Game: $i\n $valid');

      sum += maxRed * maxBlue * maxGreen;
    }

    return sum;
  }

  bool checkIfValid(int parRed, int parGreen, int parBlue) {
    return (parRed <= Configuration.red.amount &&
        parGreen <= Configuration.green.amount &&
        parBlue <= Configuration.blue.amount);
  }
}
