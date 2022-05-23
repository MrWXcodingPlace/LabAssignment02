import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditController = TextEditingController();
  TextEditingController textEditController2 = TextEditingController();
  double numA = 0, numB = 0, result = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Calculator'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Simple Calculator",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: textEditController,
                  decoration: InputDecoration(
                    hintText: "First Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                TextField(
                  controller: textEditController2,
                  decoration: InputDecoration(
                    hintText: "First Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // For Add Functions
                    ElevatedButton(
                      onPressed: () {
                        calculate("+");
                      },
                      child: const Text("+"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // For Substract Functions
                    ElevatedButton(
                      onPressed: () {
                        calculate("-");
                      },
                      child: const Text("-"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // For Multiple Functions
                    ElevatedButton(
                      onPressed: () {
                        calculate("*");
                      },
                      child: const Text("*"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // For Divide Functions
                    ElevatedButton(
                      onPressed: () {
                        calculate("/");
                      },
                      child: const Text("/"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Result: " + result.toString(),
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculate(String op) {
    setState(() {
      numA = double.parse(textEditController.text);
      numB = double.parse(textEditController2.text);
      switch (op) {
        case '+':
          result = numA + numB;
          break;
        case '-':
          result = numA - numB;
          break;
        case '*':
          result = numA * numB;
          break;
        case '/':
          result = numA / numB;
          break;
      }
    });
  }
}
