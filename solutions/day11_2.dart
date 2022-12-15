import 'package:collection/collection.dart';
import 'package:more/more.dart';
//import 'package:collection/collection.dart';

class Monkey {
  List<int> items;
  String operation;
  int worryFactor;
  int divisor;
  List<int> destinations;
  int inspections = 0;
  Monkey(this.items, this.operation, this.worryFactor, this.divisor,
      this.destinations);

  factory Monkey.fromStringList(List<String> m) {
    var items = m[1].split(': ').last.split(', ').map(int.parse).toList();
    var op = m[2].split('= ').last;
    var div = int.parse(m[3].split('by ').last);
    var dests =
        [m[4], m[5]].map((e) => int.parse(e.split('monkey ').last)).toList();
    return Monkey(items, op, 3, div, dests);
  }
  int findDest() {
    inspections += 1;
    var parts = operation.split(' ');
    int arg1 = parts[0] == 'old' ? items.first : int.parse(parts[0]);
    int arg2 = parts[2] == 'old' ? items.first : int.parse(parts[2]);
    var op = parts[1];
    var val = 0;
    if (op == '*') {
      val = arg1 * arg2;
    } else if (op == '+') {
      val = arg1 + arg2;
    } else if (op == '-') {
      val = arg1 - arg2;
    }
    // Apply general worry rule
    val ~/= worryFactor;

    items[0] = val;
    return (val % divisor == 0) ? destinations.first : destinations.last;
  }
}

part1(List<String> lines) {
  var inputs = lines.chunked(7);
  var monkeys = <Monkey>[];
  for (var m in inputs) {
    monkeys.add(Monkey.fromStringList(m)..worryFactor = 3);
  }
  for (var _ in 0.to(20)) {
    for (var m in monkeys) {
      while (m.items.isNotEmpty) {
        var dest = m.findDest();
        var item = m.items.removeAt(0);
        monkeys[dest].items.add(item);
      }
    }
  }
  return monkeys
      .map((e) => e.inspections)
      .toList()
      .sorted((a, b) => b.compareTo(a))
      .take(2)
      .reduce((s, t) => s * t);
}

part2(List<String> lines) {
  var inputs = lines.chunked(7);
  var monkeys = <Monkey>[];
  var minCommonMult = 1;
  for (var m in inputs) {
    var monkey = Monkey.fromStringList(m)..worryFactor = 1;
    minCommonMult *= monkey.divisor;
    monkeys.add(monkey);
  }
  for (var _ in 0.to(10000)) {
    for (var m in monkeys) {
      while (m.items.isNotEmpty) {
        var dest = m.findDest();
        var item = m.items.removeAt(0);
        // mod by the minimum common mulitplier of all the operations.
        item = item % minCommonMult;
        monkeys[dest].items.add(item);
      }
    }
  }
  return monkeys
      .map((e) => e.inspections)
      .toList()
      .sorted((a, b) => b.compareTo(a))
      .take(2)
      .reduce((s, t) => s * t);
}
