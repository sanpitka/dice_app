import 'package:flutter/material.dart';
import 'package:dice_app/components/dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiceApp',
      theme: ThemeData( scaffoldBackgroundColor: const Color.fromARGB(255, 241, 208, 108),),
      home: const Dice(),
    );
  }
}
