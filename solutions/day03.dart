import '../utils/index.dart';

class ElveGroup {
  String bag1;
  String bag2;
  String bag3;

  ElveGroup(this.bag1, this.bag2, this.bag3);

  int getEqualChar() {
    var list1 = bag1.split('');
    var list2 = bag2.split('');
    var list3 = bag3.split('');
    var result = (list1.firstWhere(
            (element) => list2.contains(element) && list3.contains(element)))
        .codeUnitAt(0);
    if (result > 96) {
      result -= 96;
    } else {
      result -= 38;
    }
    return result;
  }
}

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  parseInput() {
    var list = input.getPerLine();
    list.removeLast();
    var result = list
        .map((e) {
          int midPos = e.length ~/ 2;
          var list1 = e.substring(0, midPos).split('');
          var list2 = e.substring(midPos, e.length).split('');
          var value = (list1.firstWhere((element) => list2.contains(element)))
              .codeUnitAt(0);
          if (value > 96) {
            value -= 96;
          } else {
            value -= 38;
          }
          return value;
        })
        .toList()
        .sum;

    return result;
  }

  parseInput2() {
    var list = input.getPerLine();
    list.removeLast();
    List<int> elveList = [];
    for (var i = 0; i < list.length; i += 3) {
      elveList.add(ElveGroup(list[i], list[i + 1], list[i + 2]).getEqualChar());
    }
    return elveList.sum;
  }

  @override
  int solvePart1() {
    return parseInput();
  }

  @override
  int solvePart2() {
    return parseInput2();
  }
}
