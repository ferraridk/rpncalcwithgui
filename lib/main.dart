import 'dart:io';
import 'package:flutter/material.dart';

import 'AddCommand.dart';
import 'SubtractCommand.dart';
import 'MultiplyCommand.dart';
import 'DivideCommand.dart';
import 'PushCommand.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<double> stack = [];
  var commands = {
    "+": AddCommand(),
    "-": SubtractCommand(),
    "*": MultiplyCommand(),
    "/": DivideCommand(),
  };
  var executedCommands = [];

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_handleTextEditingController);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_handleTextEditingController);
    _textEditingController.dispose();
    super.dispose();
  }

  void _handleTextEditingController() {
    var text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      handleButtonPress(text);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  stack.isEmpty ? "0" : stack.last.toString(),
                  style: TextStyle(fontSize: 48.0, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                  buildButton("C"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*"),
                  buildButton("Undo"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                  buildButton("Enter"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("+"),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            onPrimary: Colors.white,
          ),
          onPressed: () {
            setState(() {
              handleButtonPress(buttonText);
            });
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  void handleButtonPress(String buttonText) {
    if (buttonText == "C") {
      stack.clear();
      executedCommands.clear();
    } else if (buttonText == "Undo") {
      if (executedCommands.isNotEmpty) {
        var lastCommand = executedCommands.removeLast();
        lastCommand.undo(stack);
      } else {
        print("Error: Nothing to undo");
      }
    } else if (buttonText == "Enter") {
      if (stack.isNotEmpty) {
        var command = PushCommand(stack.last);
        executedCommands.add(command);
      }
    } else if (commands.containsKey(buttonText)) {
      if (stack.length >= 2) {
        var command = commands[buttonText];
        command?.execute(stack);
        executedCommands.add(command);
      } else {
        print("Error: Insufficient operands");
      }
    } else {
      try {
        var value = double.parse(buttonText);
        stack.add(value);
      } catch (e) {
        print("Error: Invalid input");
      }
    }
  }
}