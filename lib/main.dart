import 'package:flutter/material.dart';

const String appName = 'Number Shapes';
const String descriptionText = 'Please input a number to see if it is square or cubic.';
const String fieldErrorMessage = 'Enter a number!';
const String noneMessage = 'is neither CUBIC nor SQUARE.';
const String cubicMessage = 'is CUBIC';
const String squareMessage = 'is SQUARE';
const String squareAndCubicMessage = 'is both SQUARE and CUBIC';

void main() {
  runApp(const NumberShapes());
}

class NumberShapes extends StatelessWidget {
  const NumberShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Form(),
    );
  }
}

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final TextEditingController fieldController = TextEditingController();
  int? enteredNumber;
  String? errorMessage;

  bool isSquare(int number) {
    for (int i = 1; i * i <= number; i++) {
      if (i * i == number) {
        return true;
      }
    }
    return false;
  }

  bool isCubic(int number) {
    for (int i = 1; i * i * i <= number; i++) {
      if (i * i * i == number) {
        return true;
      }
    }
    return false;
  }

  String getNumberShapeMessage(int number) {
    final bool square = isSquare(number);
    final bool cubic = isCubic(number);
    String partialMessage;
    if (square && cubic) {
      partialMessage = squareAndCubicMessage;
    } else if (square) {
      partialMessage = squareMessage;
    } else if (cubic) {
      partialMessage = cubicMessage;
    } else {
      partialMessage = noneMessage;
    }
    return 'Number $number $partialMessage';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            appName,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const Text(
              descriptionText,
            ),
            TextField(
              controller: fieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: errorMessage,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          enteredNumber = int.tryParse(fieldController.value.text);
          if (enteredNumber == null) {
            setState(() {
              fieldController.clear();
              errorMessage = fieldErrorMessage;
            });
          } else {
            setState(() {
              errorMessage = null;
            });
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('${enteredNumber!}'),
                content: Text(getNumberShapeMessage(enteredNumber!)),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
