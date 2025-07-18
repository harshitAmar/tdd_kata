class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    List<String> delimiters = [","]; // default delimiter
    final multiDelimiterPattern = RegExp(r"\[(.*?)\]");
    final singleCharDelimiterPattern = RegExp(r"^//(.)\n");

    if (numbers.startsWith("//")) {
      final headerEnd = numbers.indexOf('\n');
      final header = numbers.substring(2, headerEnd);

      final matches = multiDelimiterPattern.allMatches(header);
      if (matches.isNotEmpty) {
        delimiters = matches.map((m) => RegExp.escape(m.group(1)!)).toList();
      } else if (singleCharDelimiterPattern.hasMatch(numbers)) {
        final match = singleCharDelimiterPattern.firstMatch(numbers)!;
        delimiters = [RegExp.escape(match.group(1)!)];
      }

      numbers = numbers.substring(headerEnd + 1);
    }

    // Only replace \n if we have a single-character delimiter
    if (delimiters.length == 1 && delimiters[0].length == 1) {
      numbers = numbers.replaceAll('\n', delimiters[0]);
    }

    final splitPattern = RegExp(delimiters.join("|"));
    List<String> values = numbers.split(splitPattern);

    List<int> negatives = [];
    int valueToReturn = 0;

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
