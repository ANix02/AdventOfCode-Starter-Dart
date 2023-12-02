import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);
  List<int> result = [];
  List<String> stringList = [];
  @override
  parseInput() {
    stringList = input.getPerLine().map((e) => e).toList();
    for (int i = 0; i < stringList.length; i++) {
      stringList[i] = ParseUtil.replaceTextNumber(stringList[i]);
      // print(stringList[i]);
    }
    stringList = stringList.map(ParseUtil.intInString).toList();
  }

  @override
  int solvePart1() {
    parseInput();
    final firstNumberList = stringList.map((e) => e.substring(0, 1)).toList();
    final secondNumberList =
        stringList.map((e) => e.substring(e.length - 1)).toList();
    for (int i = 0; i < firstNumberList.length; i++) {
      result.add(int.parse(firstNumberList[i] + secondNumberList[i]));
    }
    return result.fold(0, (previousValue, element) => previousValue + element);
  }

  @override
  int solvePart2() {
    parseInput();
    result.clear();
    final firstNumberList = stringList.map((e) => e.substring(0, 1)).toList();
    final secondNumberList =
        stringList.map((e) => e.substring(e.length - 1)).toList();
    for (int i = 0; i < firstNumberList.length; i++) {
      result.add(int.parse(firstNumberList[i] + secondNumberList[i]));
      print(firstNumberList[i] + secondNumberList[i]);
    }
    return result.fold(0, (previousValue, element) => previousValue + element);
  }
}
