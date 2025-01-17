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
      theme: ThemeData( scaffoldBackgroundColor: Colors.amber,),
      home: const Dice(title: 'DiceApp'),
    );
  }
}

/* class Dice extends StatefulWidget {
  const Dice({super.key, required this.title});
  
  final String title;

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int _roll = 0;

  void _diceroll() {
    setState(() {
      _roll = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48), // Image radius
                child: Image.asset('assets/images/dice$_roll.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _diceroll();
              },
              child: const Text('Heitä noppaa'),
            ),
          ],
        ),
      ),
    );
  }
}
 */