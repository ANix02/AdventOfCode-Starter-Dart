import '../utils/index.dart';

class Tree {
  final int name;
  final Tree? top;
  final Tree? bottom;
  final Tree? left;
  final Tree? right;

  Tree(this.name, this.top, this.bottom, this.left, this.right);
}

class Day08 extends GenericDay {
  Day08() : super(8);

  @override
  parseInput() {
    var lines = input.getPerLine();
    print(lines[0].length);
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
