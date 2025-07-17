class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    int? valueToReturn = int.tryParse(numbers);

    if (valueToReturn != null) {
      return valueToReturn;
    } else {
      throw Exception("float values are not considered");
    }
  }
}
