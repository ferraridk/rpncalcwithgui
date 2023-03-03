// Abstract class that defines the interface for all commands
abstract class Command {
  // Method to execute the command on the stack
  void execute(List<double> stack);

  // Method to undo the previous command
  void undo(List<double> stack);
}
