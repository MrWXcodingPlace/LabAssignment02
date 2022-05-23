import 'package:flutter/material.dart';

class BmiCalcPage extends StatelessWidget {
  const BmiCalcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Column(),
        ),
      ),
    );
  }
}
