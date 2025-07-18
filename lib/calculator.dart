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
        String delimeter = ",";

        if (numbers.startsWith("//")) {
          delimeter = numbers[2];
          numbers = numbers.substring(3);
        }
        numbers = numbers.replaceAll("\n", delimeter);
        List<String> values = numbers.split(delimeter);
        if (values.length > 1) {
          int valueToReturn = 0;

          List<int> negatives = [];
          for (var v in values) {
            int value = int.parse(v);
            if (value.isNegative) {
              negatives.add(value);
            } else {
              valueToReturn += value;
            }
          }
          if (negatives.isNotEmpty) {
            throw Exception(
                "negative numbers not allowed ${negatives.join(",")}");
          }
          return valueToReturn;
        } else {
          throw Exception("string is not considered");
        }
      }
    }
  }
}

void main(List<String> args) {
  final calculator = Calculator();

  try {
    calculator.add("//|2\n3|8\n3|-89");
  } catch (e) {
    print(e.toString());
  }
}
