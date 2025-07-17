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
        try {
          String delimeter = ",";

          if (numbers.startsWith("//")) {
            delimeter = numbers[2];
            numbers = numbers.substring(3);
          }
          numbers = numbers.replaceAll("\n", delimeter);
          List<String> values = numbers.split(delimeter);
          if (values.length > 1) {
            int valueToReturn = 0;
            for (var v in values) {
              valueToReturn += int.parse(v);
            }
            return valueToReturn;
          } else {
            throw Exception("string is not considered");
          }
        } catch (e) {
          print("$e");
          throw Exception("string is not considered");
        }
      }
    }
  }
}

void main(List<String> args) {
  final calculator = Calculator();

  calculator.add("//*2\n3*8\n3*89");
}
