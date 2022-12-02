import '../utils/index.dart';

class Elf {
  int number;
  int calories;
  Elf(this.number, this.calories);
}

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  parseInput() {
    List<Elf> result = [];
    var index = 1;

    var list = input.asString.split('\n\n');
    list.forEach((element) {
      var elementList = element.split('\n');
      var sum = 0;
      elementList.forEach((e) {
        if (e != '') {
          sum += int.parse(e);
        }
      });
      result.add(Elf(index, sum));
      print('$index, $sum');
      index++;
    });

    result.sort((a, b) => a.calories.compareTo(b.calories));
    var result2 = 0;
    result2 += result[result.length - 1].calories;
    result2 += result[result.length - 2].calories;
    result2 += result[result.length - 3].calories;
    print(result2);

    // var sortedMap = Map.fromEntries(result.entries.toList()
    //   ..sort(
    //     (a, b) => a.value.compareTo(b.value),
    //   ));
    // print('${sortedMap.keys.last}, ${sortedMap.values.last}');
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
