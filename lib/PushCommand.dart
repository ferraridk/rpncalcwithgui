import 'Command.dart';

// Class that implements the `Command` interface and pushes a value onto the stack
class PushCommand implements Command {
  final double value;

  // Constructor that sets the value to be pushed onto the stack
  PushCommand(this.value);

  void execute(List<double> stack) {
    // Push the value onto the stack
    stack.add(value);
    // Print a confirmation message
    print("Value added to stack");
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