import '../utils/index.dart';
import 'package:more/more.dart';
import 'package:collection/collection.dart';

class Day04 extends GenericDay {
  Day04() : super(4);
  List<String> list = [];

  @override
  parseInput() {
    list = input.getPerLine();
    list.removeLast();
    var result = list
        .map((line) {
          var subStrings = line.split(',');
          var sub1 = subStrings[0].split('-');
          var sub2 = subStrings[1].split('-');

          if ((int.parse(sub1[0]) >= int.parse(sub2[0]) &&
                  int.parse(sub1[1]) <= int.parse(sub2[1])) ||
              (int.parse(sub2[0]) >= int.parse(sub1[0]) &&
                  int.parse(sub2[1]) <= int.parse(sub1[1]))) {
            return 1;
          } else
            return 0;
        })
        .toList()
        .sum;

    return result;
  }

  parseInput2() {
    list = input.getPerLine();
    list.removeLast();
    var result = list
        .map((line) {
          var subStrings = line.split(',');
          var sub1 = subStrings[0].split('-');
          var sub2 = subStrings[1].split('-');
          var interval1 =
              Interval.closed(int.parse(sub1[0]), int.parse(sub1[1]));
          var interval2 =
              Interval.closed(int.parse(sub2[0]), int.parse(sub2[1]));
          if (interval1.contains(int.parse(sub2[0])) ||
              interval1.contains(int.parse(sub2[1])) ||
              interval2.contains(int.parse(sub1[0])) ||
              interval2.contains(int.parse(sub1[1]))) {
            return 1;
          } else
            return 0;
        })
        .toList()
        .sum;

    return result;
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
