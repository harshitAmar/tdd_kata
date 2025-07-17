import 'package:tdd_kata/calculator.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator', () {
    final calculator = Calculator();

    test("Handle empty string", () {
      expect(calculator.add(""), equals(0));
    });

    test("Convert single integer string to int", () {
      expect(calculator.add("5"), equals(5));
    });

    test("Add comma sepearted value", () {
      expect(calculator.add("2,3"), equals(5));
    });
    test("expect more than two values", () {
      expect(calculator.add("2,3,95"), equals(100));
    });
    test("consider /n as comma", () {
      expect(calculator.add("2\n3,8"), equals(13));
    });
    test("Throw exception for float values", () {
      expect(
        () => calculator.add("5.0"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: float values are not considered')),
      );
    });
    test("Throw exception for string values", () {
      expect(
        () => calculator.add("tttt"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString() == 'Exception: string is not considered')),
      );
    });
  });
}
