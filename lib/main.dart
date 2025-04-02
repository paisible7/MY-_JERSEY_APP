import 'package:flutter/material.dart';
import 'presentation/screens/HomeScreen.dart';

void main() {
  runApp(const MyJersey());
}

class MyJersey extends StatelessWidget {
  const MyJersey({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
    );
  }
}
