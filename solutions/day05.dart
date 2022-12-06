import 'dart:collection';
import 'dart:math';

import '../utils/index.dart';
import 'package:more/more.dart';
import 'package:stack/stack.dart';

class Day05 extends GenericDay {
  Day05() : super(5);

  @override
  List<Stack<String>> parseInput() {
    Queue();
    var listStack = input.getPerLine().sublist(0, 9);

    listStack.removeLast();
    var numberOfStacks = 9;
    List<Stack<String>> stackList = [];
    for (var i = 0; i < numberOfStacks; i++) {
      stackList.add(Stack());
    }
    print(stackList.length);

    for (var i = listStack.length - 1; i >= 0; i--) {
      var curPos = 0;
      for (var j = 0; j < stackList.length; j++) {
        // print(listStack[i]);
        if (listStack[i].substring(curPos, curPos + 3).isNotEmpty) {
          stackList[j].push(listStack[i].substring(curPos + 1, curPos + 2));
        }
        curPos += 4;
        if (listStack[i].length == curPos) {
          break;
        }
      }
    }
    for (var i = 0; i < stackList.length; i++) {
      while (stackList[i].top() == ' ') {
        stackList[i].pop();
      }
    }
    for (var i = 0; i < stackList.length; i++) {
      print('Stack: $i Length: ${stackList[i].length}');
      stackList[i].print();
    }

    var movementList = input.getPerLine().sublist(10);

    print(movementList.last);

    for (var element in movementList) {
      List<int> movement = [];

      for (var i = 0; i < element.length; i++) {
        var z = i + 1;

        if (int.tryParse(element.substring(i, z)) != null) {
          if (i < element.length - 1) {
            if (int.tryParse(element.substring(i, z + 2)) != null) {
              z += 1;
            }
          }

          movement.add(int.parse(element.substring(i, z)));
          i = z - 1;
        }
      }
      // print('${movement[0]},${movement[1]},${movement[2]},');
      Stack<String> tempStack = Stack();
      for (var i = 0; i < movement[0]; i++) {
        var stack = stackList[movement[1] - 1].pop();
        tempStack.push(stack);
      }
      for (var i = 0; i < movement[0]; i++) {
        stackList[movement[2] - 1].push(tempStack.pop());
      }
    }

    return stackList;
  }

  @override
  int solvePart1() {
    var stackList = parseInput();
    var result = '';

    for (var element in stackList) {
      result += element.top();
    }
    print(result);
    return 0;
  }

  @override
  int solvePart2() {
    return 0;
  }
}
