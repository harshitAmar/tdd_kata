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

    test("consider /n as comma", () {
      expect(calculator.add("2\n3,8\n3,89"), equals(105));
    });

    test("custom delimeter", () {
      expect(calculator.add("//*\n2*3*8*3*89"), equals(105));
    });

    test("print negative numbers", () {
      expect(
        () => calculator.add("//|\n2\n3|8\n3|-89"),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString() == ("Exception: negative numbers not allowed -89"),
          ),
        ),
      );
    });
    test("print all negative numbers", () {
      expect(
        () => calculator.add("//|\n2\n3|8\n3|-89|-7"),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString() ==
                    ("Exception: negative numbers not allowed -89,-7"),
          ),
        ),
      );
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
    test("newline and custom delimeter", () {
      expect(calculator.add("//#\n2\n3#4"), equals(9));
    });
    test("only delimeter", () {
      expect(
        calculator.add("//|\n"),
        equals(0),
      );
    });

    test("ignore values more than 1000", () {
      expect(calculator.add("5,6243"), equals(5));
    });
    test("don't ignore 1000", () {
      expect(calculator.add("5,1000"), equals(1005));
    });
    test("test on 1001", () {
      expect(calculator.add("5,1001"), equals(5));
    });
    test("test on 999", () {
      expect(calculator.add("5,999"), equals(1004));
    });
    test("Custom delimiter of any length", () {
      expect(calculator.add("//[***]\n1***2***3"), equals(6));
    });
    test("negative and float values together", () {
      expect(
          () => calculator.add("-2,3.5"),
          throwsA(predicate((e) =>
              e is Exception &&
              (e.toString().contains("negative numbers") ||
                  e.toString().contains("float values")))));
    });
    test("Multiple single-char delimiters", () {
      expect(calculator.add("//[*][%]\n1*2%3"), equals(6));
    });

    test("Multiple multi-char delimiters", () {
      expect(calculator.add("//[***][%%]\n1***2%%3"), equals(6));
    });

    test("Multiple mixed delimiters", () {
      expect(calculator.add("//[*][%%][#]\n1*2%%3#4"), equals(10));
    });

    test("Multiple delimiters with ignored large numbers", () {
      expect(calculator.add("//[*][%]\n1*1001%2"), equals(3));
    });

    test("Multiple delimiters with negative values", () {
      expect(
        () => calculator.add("//[*][#]\n2*-4#3"),
        throwsA(
          predicate((e) =>
              e is Exception &&
              e.toString() == "Exception: negative numbers not allowed -4"),
        ),
      );
    });
    test("Delimiter with special regex characters", () {
      expect(calculator.add("//[.*]\n1.*2.*3"), equals(6));
    });

    test("Multiple delimiters with special characters", () {
      expect(calculator.add("//[+][^]\n1+2^3"), equals(6));
    });

    test("Multiple mixed-length delimiters", () {
      expect(calculator.add("//[*][%%][#][&&&]\n1*2%%3#4&&&5"), equals(15));
    });

    test("Numbers with surrounding spaces", () {
      expect(calculator.add(" 1 , 2 , 3 "), equals(6));
    });

    test("Delimiter with surrounding spaces", () {
      expect(calculator.add("//[ * ]\n1 * 2 * 3"), equals(6));
    });

    test("Multiple delimiters and empty tokens", () {
      expect(calculator.add("//[*][%]\n1**2%%3"), equals(6));
    });

    test("Custom delimiter and only large numbers", () {
      expect(calculator.add("//[***]\n1001***2000***3000"), equals(0));
    });

    test("Custom delimiter with float and string mixed", () {
      expect(
        () => calculator.add("//[***]\n1***2.5***xyz"),
        throwsA(predicate((e) =>
            e is Exception &&
            (e.toString().contains("float values") ||
                e.toString().contains("string is not considered")))),
      );
    });

    test("Only newlines in input", () {
      expect(calculator.add("\n\n"), equals(0));
    });

    test("Single character delimiter with empty values", () {
      expect(calculator.add("//;\n1;;2"), equals(3));
    });

    test("Large number between small numbers", () {
      expect(calculator.add("1,1001,2"), equals(3));
    });

    test("Single negative number only", () {
      expect(
        () => calculator.add("-1"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed -1"))),
      );
    });
  });
}
