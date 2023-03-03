import 'Command.dart';

class MultiplyCommand implements Command {
  void execute(List<double> stack) {
    if (stack.length >= 2) {
      // Remove the last two values from the stack
      var b = stack.removeLast();
      var a = stack.removeLast();
      stack.add(a * b);
      print("Result: ${stack.last}");
    } else {
      print("Error: Not enough values in stack");
    }
  }

  void undo(List<double> stack) {
    // Check if the stack is not empty
    if (stack.isNotEmpty) {
      // Remove the result of the previous add operation
      stack.removeLast();
      // Print a confirmation message
      print("Undo AddCommand: last value removed from the stack");
    } else {
      // If the stack is empty, print an error message
      print("Error: Stack is empty");
    }
  }
}