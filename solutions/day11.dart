import '../utils/index.dart';
import 'package:more/more.dart';
import 'package:collection/collection.dart';
import './day11_2.dart' as test;

class Monkey {
  final List<BigInt> worryLevels;
  final String operation;
  final BigInt test;
  final int trueMonkey;
  final int falseMonkey;
  int inspectCount = 0;

  Monkey(this.worryLevels, this.operation, this.test, this.trueMonkey,
      this.falseMonkey);
}

class Day11 extends GenericDay {
  Day11() : super(11);

  @override
  parseInput() {
    print(test.part2(input.getPerLine()));
    List<Monkey> monkeys = [];
    var lines = input.getPerLine().chunked(7);
    BigInt minCommonMult = BigInt.from(1);

    for (var line in lines) {
      var items =
          line[1].split(':')[1].split(',').map((e) => BigInt.parse(e)).toList();
      var op = line[2].split('=').last;
      var test = BigInt.parse(line[3].split('by ').last);
      var trueMonkey = int.parse(line[4].split('monkey ').last);
      var falseMonkey = int.parse(line[5].split('monkey ').last);
      minCommonMult *= test;
      monkeys.add(Monkey(items, op, test, trueMonkey, falseMonkey));
    }
    for (var i = 0; i < 10000; i++) {
      print('Runde $i');
      // for (var i = 0; i < monkeys.length; i++) {
      //   for (var item in monkeys[i].worryLevels) {
      //     print('Monkey $i: $item');
      //   }
      // }
      for (var monkey in monkeys) {
        // print('${monkey.test}');
        // List<int> itemsToDelete = [];
        for (var i = 0; i < monkey.worryLevels.length; i++) {
          monkey.inspectCount += 1;

          var oper = monkey.operation.split('old ')[1];
          if (oper.contains('*')) {
            var isNumber = int.tryParse(oper.split('*')[1]);
            if (isNumber != null) {
              monkey.worryLevels[i] *= BigInt.parse(oper.split('*')[1]);
            } else {
              monkey.worryLevels[i] *= monkey.worryLevels[i];
            }
          } else {
            var isNumber = int.tryParse(oper.split('+')[1]);
            if (isNumber != null) {
              monkey.worryLevels[i] += BigInt.parse(oper.split('+')[1]);
            } else {
              monkey.worryLevels[i] += monkey.worryLevels[i];
            }
          }

          if (monkey.worryLevels[i] % monkey.test == 0) {
            // print(monkey.worryLevels[i] % monkey.test);
            // print(monkey.trueMonkey);
            monkey.worryLevels[i] = monkey.worryLevels[i] % minCommonMult;
            monkeys[monkey.trueMonkey].worryLevels.add(monkey.worryLevels[i]);
          } else {
            // print(monkey.falseMonkey);
            monkey.worryLevels[i] = monkey.worryLevels[i] % minCommonMult;
            monkeys[monkey.falseMonkey].worryLevels.add(monkey.worryLevels[i]);
          }
          // itemsToDelete.add(monkey.worryLevels[i]);
        }
        monkey.worryLevels.clear();
        // for (var i = 0; i < itemsToDelete.length; i++) {
        //   monkey.worryLevels
        //       .removeWhere((element) => element == itemsToDelete[i]);
        // }
      }
    }
    // for (var i = 0; i < monkeys.length; i++) {
    //   for (var item in monkeys[i].worryLevels) {
    //     print('Monkey $i: $item');
    //   }
    // }
    for (var monkey in monkeys) {
      print(monkey.inspectCount);
    }
    var res = monkeys
        .map((e) => e.inspectCount)
        .toList()
        .sorted((a, b) => b.compareTo(a))
        .take(2)
        .reduce((s, t) => s * t);

    print(res);
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
