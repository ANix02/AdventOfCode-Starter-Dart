import '../utils/index.dart';

class Node<T> {
  final List value;
  final Node<T>? parent;
  final List<Node<T>> children;
  final List<File> files = [];
  Node(this.value, this.children, this.parent);

  void addFile(String name, int size) {
    final newFile = File(name, size);
    files.add(newFile);
    value[1] += size;
    var currParent = parent;
    while (currParent != null) {
      currParent.value[1] += size;
      currParent = currParent.parent;
    }
  }
}

class File {
  final String name;
  final int size;
  File(this.name, this.size);
}

class Day07 extends GenericDay {
  Day07() : super(7);

  @override
  parseInput() {
    var lines = input.getPerLine();
    Node directory = Node(['', 0], [], null);
    var currNode = directory;

    for (var i = 0; i < lines.length; i++) {
      var command = lines[i].substring(0, 4);

      switch (command) {
        case '\$ cd':
          var rest = lines[i].substring(5);

          if (rest == '/') {
            directory.value[0] = rest;
            directory.value[1] = 0;
            currNode = directory;
          } else if (rest == '..') {
            currNode = currNode.parent!;
          } else {
            currNode = currNode.children
                .firstWhere((element) => element.value[0] == rest);
          }
          break;
        case '\$ ls':
          while (!lines[i + 1].startsWith('\$')) {
            i++;

            if (lines[i].startsWith('dir')) {
              currNode.children
                  .add(Node([lines[i].substring(4), 0], [], currNode));
            } else {
              var line = lines[i].split(' ');
              currNode.addFile(line[1], int.parse(line[0]));
            }
            if (i == lines.length - 1) {
              break;
            }
          }
          break;
        default:
          break;
      }
    }
    num requiredSpace = 30000000 - (70000000 - directory.value[1]);
    print(countFolderSize(directory, 100000));
    print(findMinSize(directory, requiredSpace).min);
  }

  int countFolderSize(Node node, int maxValue) {
    if (node.children == []) {
      return node.value[1] <= maxValue ? node.value[1] : 0;
    }
    int sum = 0;
    for (var element in node.children) {
      sum += countFolderSize(element, maxValue);
    }
    return (node.value[1] <= maxValue ? node.value[1] : 0) + sum;
  }

  List<num> findMinSize(Node node, num size) {
    if (node.children == []) {
      return node.value[1] >= size ? [node.value[1]] : [];
    }
    List<num> result = [];
    for (var element in node.children) {
      result.addAll(findMinSize(element, size));
    }
    if (node.value[1] >= size) {
      result.addAll([node.value[1]]);
    }
    return result;
  }

  num findMinSizeToDelete(Node node, num sizeToDelete) {
    if (node.children == []) {
      return node.value[1] >= sizeToDelete ? node.value[1] : 70000000;
    }
    num minValue = 70000000;
    for (var element in node.children) {
      num newValue = findMinSizeToDelete(element, sizeToDelete);
      minValue = newValue <= minValue ? newValue : minValue;
    }

    return (node.value[1] >= sizeToDelete && node.value[1] <= minValue)
        ? node.value[1]
        : minValue;
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
