class Calculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    return int.tryParse(numbers) ?? double.parse(numbers).round();
  }
}
