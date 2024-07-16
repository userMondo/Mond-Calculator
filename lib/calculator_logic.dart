import 'dart:math';

class CalculatorLogic {
  String output = '0';
  String currentNumber = '';
  String operation = '';
  double firstNumber = 0;
  double secondNumber = 0;
  List<String> history = [];

  void handleInput(String input) {
    if (input == 'C') {
      clear();
    } else if (input == '⌫') {
      backspace();
    } else if (input == '+' ||
        input == '-' ||
        input == '×' ||
        input == '÷' ||
        input == '%' ||
        input == '^' ||
        input == '√') {
      handleOperation(input);
    } else if (input == '=') {
      calculateResult();
    } else {
      handleNumber(input);
    }
  }

  void clear() {
    output = '0';
    currentNumber = '';
    operation = '';
    firstNumber = 0;
    secondNumber = 0;
  }

  void backspace() {
    if (currentNumber.isNotEmpty) {
      currentNumber = currentNumber.substring(0, currentNumber.length - 1);
      if (currentNumber.isEmpty) {
        currentNumber = '0';
      }
      output = currentNumber;
    } else if (operation.isNotEmpty) {
      operation = '';
    }
  }

  void handleOperation(String op) {
    if (currentNumber.isNotEmpty) {
      firstNumber = double.parse(currentNumber);
      operation = op;
      currentNumber = '';
    } else if (operation.isEmpty) {
      operation = op;
    } else {
      operation =
          op; // Allow changing the operator before entering the second number
    }
  }

  void handleNumber(String num) {
    if (currentNumber == '0') {
      currentNumber = num;
    } else {
      currentNumber += num;
    }
    output = currentNumber;
  }

  void calculateResult() {
    if (currentNumber.isNotEmpty && operation.isNotEmpty) {
      secondNumber = double.parse(currentNumber);
      double result;
      String operationString = '$firstNumber $operation $secondNumber';

      try {
        switch (operation) {
          case '+':
            result = firstNumber + secondNumber;
            break;
          case '-':
            result = firstNumber - secondNumber;
            break;
          case '×':
            result = firstNumber * secondNumber;
            break;
          case '÷':
            if (secondNumber == 0) throw Exception('Division by zero');
            result = firstNumber / secondNumber;
            break;
          case '%':
            result = firstNumber % secondNumber;
            break;
          case '^':
            result = pow(firstNumber, secondNumber).toDouble();
            break;
          case '√':
            if (firstNumber < 0)
              throw Exception('Invalid input for square root');
            result = sqrt(firstNumber);
            operationString = '√$firstNumber';
            break;
          default:
            throw Exception('Invalid operation');
        }

        output = result
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
        history.add('$operationString = $output');
        currentNumber = output;
        operation = '';
      } catch (e) {
        output = 'Error: ${e.toString()}';
        currentNumber = '';
        operation = '';
      }
    }
  }
}
