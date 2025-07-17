class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    int? valueToReturn = int.tryParse(numbers);

    if (valueToReturn != null) {
      return valueToReturn;
    } else {
      if (num.tryParse(numbers) != null) {
        throw Exception("float values are not considered");
      } else {
        List<String> values = numbers.split(",");

        if (values.length > 1) {
          int valueToReturn = 0;
          for (var v in values) {
            valueToReturn += int.parse(v);
          }
          return valueToReturn;
        }
      }

      {
        throw Exception("string is not considered");
      }
    }
  }
}
