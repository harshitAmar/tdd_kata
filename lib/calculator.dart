class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    String delimeter = ",";

    final multiCharDelimiterPattern = RegExp(r"^//\[(.+?)\]\n");
    final singleCharDelimiterPattern = RegExp(r"^//(.)\n");
    bool isMultiCharDelimiter = false;

    if (numbers.startsWith("//")) {
      if (multiCharDelimiterPattern.hasMatch(numbers)) {
        final match = multiCharDelimiterPattern.firstMatch(numbers)!;
        delimeter = match.group(1)!;
        numbers = numbers.substring(match.end);
        isMultiCharDelimiter = true;
      } else if (singleCharDelimiterPattern.hasMatch(numbers)) {
        final match = singleCharDelimiterPattern.firstMatch(numbers)!;
        delimeter = match.group(1)!;
        numbers = numbers.substring(match.end);
      }
    }

    if (numbers.trim().isEmpty) {
      throw Exception("string is not considered");
    }

// Only replace \n if the delimiter is single-character
    if (!isMultiCharDelimiter) {
      numbers = numbers.replaceAll("\n", delimeter);
    }

    List<String> values = numbers.split(delimeter);

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
