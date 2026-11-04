import 'dart:io';

double? parseNumber(String input) {
  try {
    return double.parse(input.trim());
  } catch (e) {
    return null;
  }
}

bool isValidOperator(String op) {
  return ['+', '-', '*', '/', '%'].contains(op.trim());
}

void main() {
  List<String> history = [];
  late double result;

  while (true) {
    stdout.write("Enter first number: ");
    String? input = stdin.readLineSync();
    double? num = parseNumber(input ?? '');

    if (num != null) {
      result = num;
      break;
    } else {
      print("Invalid input! Please enter a valid number.");
    }
  }

  print(
    "\nCalculator started. Commands: use operators (+, -, *, /, %), 'history' to see all calculations, 'exit' to quit\n",
  );

  while (true) {
    stdout.write("Operator (+ - * / %), 'history', or 'exit': ");
    String? opInput = stdin.readLineSync();
    if (opInput == null) {
      // EOF (Ctrl+D / piped input ended): exit cleanly like 'exit'.
      print("\n=== Final Result: $result ===");
      if (history.isNotEmpty) {
        print("\n=== Calculation History ===");
        for (int i = 0; i < history.length; i++) {
          print("${i + 1}. ${history[i]}");
        }
      }
      break;
    }
    String op = opInput.toLowerCase().trim();

    if (op == 'exit') {
      print("\n=== Final Result: $result ===");
      if (history.isNotEmpty) {
        print("\n=== Calculation History ===");
        for (int i = 0; i < history.length; i++) {
          print("${i + 1}. ${history[i]}");
        }
      }
      break;
    }

    if (op == 'history') {
      if (history.isEmpty) {
        print("No calculations yet.");
      } else {
        print("\n=== Calculation History ===");
        for (int i = 0; i < history.length; i++) {
          print("${i + 1}. ${history[i]}");
        }
        print("Current Result: $result\n");
      }
      continue;
    }

    if (!isValidOperator(op)) {
      print("Invalid operator! Use +, -, *, /, or %");
      continue;
    }

    double? num;
    while (num == null) {
      stdout.write("Enter next number: ");
      String? input = stdin.readLineSync();
      num = parseNumber(input ?? '');

      if (num == null) {
        print("Invalid input! Please enter a valid number.");
      }
    }

    double previousResult = result;
    String calculation = "$previousResult $op $num";

    switch (op) {
      case "+":
        result = result + num;
        break;
      case "-":
        result = result - num;
        break;
      case "*":
        result = result * num;
        break;
      case "/":
        if (num == 0) {
          print("Error: Cannot divide by zero!");
          continue;
        }
        result = result / num;
        break;
      case "%":
        if (num == 0) {
          print("Error: Cannot modulo by zero!");
          continue;
        }
        result = result % num;
        break;
    }

    history.add("$calculation = $result");
    print("Current Result: $result");
  }
}
