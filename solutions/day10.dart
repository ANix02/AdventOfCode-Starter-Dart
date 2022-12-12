import '../utils/index.dart';

class Day10 extends GenericDay {
  Day10() : super(10);
  final Map<int, int> cycleResults = {};
  List<String> res = ['', '', '', '', '', ''];
  int iterator = 0;

  @override
  parseInput() {
    var prog = input
        .getPerLine()
        .expand((l) => [0] + (l.length > 4 ? [int.parse(l.substring(5))] : []))
        .toList();
    var x = 1, out = "";
    for (int i = 0, j = 0; i < 240; j = ++i % 40) {
      out +=
          (j == 0 && i > 0 ? "\n" : "") + (j - x > -2 && j - x < 2 ? "#" : ".");
      x += prog[i % prog.length];
    }
    print(out);

    var lines = input.getPerLine();
    int sum = 1;
    var cycleTimer = 0;
    checkTimer2(cycleTimer, sum);
    for (var line in lines) {
      // print('Tick: $cycleTimer Sum: $sum');
      if (line.startsWith('addx')) {
        cycleTimer += 1;
        checkTimer2(cycleTimer, sum);
        cycleTimer += 1;
        checkTimer2(cycleTimer, sum);
        sum += int.parse(line.substring(5));
      } else {
        cycleTimer += 1;
        checkTimer2(cycleTimer, sum);
      }
    }
    print(cycleTimer);
    var result = 0;

    // for (var element in cycleResults.entries) {
    //   result += element.value;
    //   print(element.value);
    // }
    // print(result);
    print(res[1]);

    for (var line in res) {
      print(line);
    }
  }

  checkTimer2(int timer, int sum) {
    if (timer <= 39) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[iterator] += '#';
      } else {
        res[iterator] += ' ';
      }
      if (timer == 39) {
        iterator += 1;
      }
    } else if (timer <= 79) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[1] += '#';
      } else {
        res[1] += ' ';
      }
    } else if (timer <= 119) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[2] += '#';
      } else {
        res[2] += ' ';
      }
    } else if (timer <= 159) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[3] += '#';
      } else {
        res[3] += ' ';
      }
    } else if (timer <= 199) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[4] += '#';
      } else {
        res[4] += ' ';
      }
    } else if (timer <= 239) {
      if (timer >= sum - 1 && timer <= sum + 1) {
        res[5] += '#';
      } else {
        res[5] += ' ';
      }
    }
  }

  checkTimer(int timer, int sum) {
    switch (timer) {
      case 20:
        cycleResults[timer] = sum * timer;
        break;
      case 60:
        cycleResults[timer] = sum * timer;
        break;
      case 100:
        cycleResults[timer] = sum * timer;
        break;
      case 140:
        cycleResults[timer] = sum * timer;
        break;
      case 180:
        cycleResults[timer] = sum * timer;
        break;
      case 220:
        cycleResults[timer] = sum * timer;
        break;
      default:
        break;
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
