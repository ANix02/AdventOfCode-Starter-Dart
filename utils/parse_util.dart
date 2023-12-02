class ParseUtil {
  /// Throws an exception if any given String is not parseable.
  static List<int> stringListToIntList(List<String> strings) {
    return strings.map(int.parse).toList();
  }

  /// Returns decimal number from binary string
  static int binaryToDecimal(String binary) {
    return int.parse(binary, radix: 2);
  }

  static String intInString(String string) {
    return string.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String replaceTextNumber(String string) {
    final List<int> indexList = [];
    indexList
      ..add(string.indexOf('one'))
      ..add(string.indexOf('two'))
      ..add(string.indexOf('three'))
      ..add(string.indexOf('four'))
      ..add(string.indexOf('five'))
      ..add(string.indexOf('six'))
      ..add(string.indexOf('seven'))
      ..add(string.indexOf('eight'))
      ..add(string.indexOf('nine'));

    final List<int> lastIndexList = [];
    lastIndexList
      ..add(string.lastIndexOf('one'))
      ..add(string.lastIndexOf('two'))
      ..add(string.lastIndexOf('three'))
      ..add(string.lastIndexOf('four'))
      ..add(string.lastIndexOf('five'))
      ..add(string.lastIndexOf('six'))
      ..add(string.lastIndexOf('seven'))
      ..add(string.lastIndexOf('eight'))
      ..add(string.lastIndexOf('nine'));

    int minIndex = 99;
    int minValue = -1;
    int maxIndex = -1;
    int maxValue = -1;

    for (int i = 0; i < indexList.length; i++) {
      if (indexList[i] > -1 && indexList[i] < minIndex) {
        minIndex = indexList[i];
        minValue = i + 1;
      }
      if (lastIndexList[i] > -1 && lastIndexList[i] > maxIndex) {
        maxIndex = lastIndexList[i];
        maxValue = i + 1;
      }
    }
    var firstSwitch = '';
    switch (minValue) {
      case 1:
        firstSwitch = string.replaceFirst('one', '1one');
      case 2:
        firstSwitch = string.replaceFirst('two', '2two');
      case 3:
        firstSwitch = string.replaceFirst('three', '3three');
      case 4:
        firstSwitch = string.replaceFirst('four', '4four');
      case 5:
        firstSwitch = string.replaceFirst('five', '5five');
      case 6:
        firstSwitch = string.replaceFirst('six', '6six');
      case 7:
        firstSwitch = string.replaceFirst('seven', '7seven');
      case 8:
        firstSwitch = string.replaceFirst('eight', '8eight');
      case 9:
        firstSwitch = string.replaceFirst('nine', '9nine');
      default:
        firstSwitch = string;
    }

    var secondSwitch = '';
    switch (maxValue) {
      case 1:
        secondSwitch = firstSwitch.replaceAll('one', '1one');
      case 2:
        secondSwitch = firstSwitch.replaceAll('two', '2two');
      case 3:
        secondSwitch = firstSwitch.replaceAll('three', '3three');
      case 4:
        secondSwitch = firstSwitch.replaceAll('four', '4four');
      case 5:
        secondSwitch = firstSwitch.replaceAll('five', '5five');
      case 6:
        secondSwitch = firstSwitch.replaceAll('six', '6six');
      case 7:
        secondSwitch = firstSwitch.replaceAll('seven', '7seven');
      case 8:
        secondSwitch = firstSwitch.replaceAll('eight', '8eight');
      case 9:
        secondSwitch = firstSwitch.replaceAll('nine', '9nine');
      default:
        secondSwitch = firstSwitch;
    }

    return secondSwitch;
  }
}
