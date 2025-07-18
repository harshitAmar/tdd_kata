class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    List<String> delimiters = [","];
    final multiCharDelimeterPattern = RegExp(r'\[([^\]]+)\]');
    final singleCharDelimiterPattern = RegExp(r"^//(.)\n");

    if (numbers.startsWith("//")) {
      final headerEnd = numbers.indexOf('\n');
      final header = numbers.substring(2, headerEnd);

      final delimiterMatches = multiCharDelimeterPattern.allMatches(header);
      if (delimiterMatches.isNotEmpty) {
        delimiters =
            delimiterMatches.map((m) => RegExp.escape(m.group(1)!)).toList();
      } else if (singleCharDelimiterPattern.hasMatch(numbers)) {
        final match = singleCharDelimiterPattern.firstMatch(numbers)!;
        delimiters = [RegExp.escape(match.group(1)!)];
      }

      numbers = numbers.substring(headerEnd + 1);
    }

    delimiters.add('\n');

    final splitPattern = RegExp(delimiters.join("|"));
    List<String> values = numbers.split(splitPattern);

    List<int> negatives = [];
    int valueToReturn = 0;

    if (values.length == 1 && values.first.trim().isEmpty) {
      return 0;
    }

    for (var v in values) {
      v = v.trim();

      if (v.isEmpty) continue;

      if (int.tryParse(v) == null) {
        if (num.tryParse(v) != null) {
          throw Exception("float values are not considered");
        } else {
          throw Exception("string is not considered");
        }
      }

      int value = int.parse(v);

      if (value.isNegative) {
        negatives.add(value);
      } else if (value <= 1000) {
        valueToReturn += value;
      }
    }

    if (negatives.isNotEmpty) {
      throw Exception("negative numbers not allowed ${negatives.join(",")}");
    }

    return valueToReturn;
  }
}

void main(List<String> args) {
  var v = Calculator().add("//|\n2\n3|8\n3|-89|-7");
  print(v);
}
