import 'package:tdd_kata/calculator.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator', () {
    test("Handle empty string", () {
      final calculator = Calculator();
      expect(calculator.add(""), equals(0));
    });

    test("Convert single integer string to int", () {
      final calculator = Calculator();
      expect(calculator.add("5"), equals(5));
    });

    test("Throw exception for float values", () {
      final calculator = Calculator();
      expect(
        () => calculator.add("5.0"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: float values are not considered')),
      );
    });
    test("Throw exception for string values", () {
      final calculator = Calculator();
      expect(
        () => calculator.add("tttt"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: string is not considered')),
      );
    });
  });
}
