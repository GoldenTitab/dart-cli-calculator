# Dart CLI Calculator

Genuinely usable interactive CLI calculator: prompt first number (re-prompt on invalid input), loop operator (`+ - * / %`, `history`, `exit`), running result, in-memory history entries `"<prev> <op> <num> = <result>"`.

## Run
```bash
dart run bin/basic_calculator.dart
```

## Example session
```
Enter first number: 10
Operator (+ - * / %), 'history', or 'exit': +
Enter next number: 5
Current Result: 15.0
Operator (+ - * / %), 'history', or 'exit': history
1. 10.0 + 5.0 = 15.0
Current Result: 15.0
Operator (+ - * / %), 'history', or 'exit': exit
=== Final Result: 15.0 ===
```

## Behaviour
- Divide/modulo by zero are guarded (error, result unchanged, nothing added to history). History is in-memory only and lost on exit.

## Bugs fixed in the 2026-11-04 audit
- Crash on EOF at the operator prompt: the operator read used `stdin.readLineSync()!` (force-unwrap), while number reads were already safe. EOF (Ctrl+D / piped input ended) is now treated exactly like `exit`, printing the final result and history.

## Notes
- `history` before any calculation prints "No calculations yet" without the current result, but after a calculation also prints "Current Result" — inconsistent format, cosmetic. Double formatting shows float artefacts (e.g. `0.30000000000000004`). `%` on doubles follows Dart's divisor-sign remainder rule, surprising for negatives. The `lib/` stub is dead code (nothing imports it).
