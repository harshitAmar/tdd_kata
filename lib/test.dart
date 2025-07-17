import 'package:tdd_kata/calculator.dart';
import 'package:test/test.dart';

void main() {
  group(
    "Calculator",
    () {
      test("Handle Empty String", () {
        Calculator calculator = Calculator();
        expect(calculator.add(""), equals(0));
      });
    },
  );
}
