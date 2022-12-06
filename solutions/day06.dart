import '../utils/index.dart';

class Day06 extends GenericDay {
  Day06() : super(6);

  @override
  parseInput() {
    var marker = 14;
    var dataStream = input.asString.trim();
    var check = [];
    var safe = true;
    do {
      check = dataStream.substring(marker - 14, marker).split('');
      safe = true;
      print(check.length);
      for (var i = 0; i < check.length - 1; i++) {
        for (var j = i + 1; j < check.length; j++) {
          if (check[i] == check[j]) {
            safe = false;
          }
        }
      }
      if (!safe) {
        marker += 1;
      }
    } while (!safe);
    print(marker);
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
