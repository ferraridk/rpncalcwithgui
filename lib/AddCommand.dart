import 'Command.dart';

// Class that implements the `Command` interface and performs addition
class AddCommand implements Command {
  void execute(List<double> stack) {
    // Check if there are at least two values in the stack
    if (stack.length >= 2) {
      // Remove the last two values from the stack
      var b = stack.removeLast();
      var a = stack.removeLast();
      // Add the two values and push the result back onto the stack
      stack.add(a + b);
      // Print the result
      print("Result: ${stack.last}");
    } else {
      // If there are not enough values in the stack, print an error message
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
