import 'dart:math';
import 'package:flutter/material.dart';

const Color buttonColor = Color.fromARGB(255, 241, 229, 190);

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  var numberOfDice = 1;
  late List<int> _rolls;

  @override
  void initState() {
    super.initState();
    _rolls = List.generate(numberOfDice, (index) => 1);
  }

  void _diceroll() {
    setState(() {
      _rolls = List.generate(numberOfDice, (index) => Random().nextInt(6) + 1);
    });
  }

  void _updateDiceCount(int change) {
    setState(() {
      numberOfDice = (numberOfDice + change).clamp(1, 12); // Maximum amount of dice is 12
      _rolls = List.generate(numberOfDice, (index) => 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Buttons for adding and removing dice
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Container(
              decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => _updateDiceCount(-1),
                ),
                IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _updateDiceCount(1),
                ),
              ],
              ),
            ),
          ),
          // Room for dice images
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 280, 
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: _rolls.map((roll) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/dice$roll.png',
                        fit: BoxFit.contain,
                        width: 80,
                        height: 80,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Roll dice button
          Padding(
            padding: const EdgeInsets.symmetric(vertical:32.0),
            child: ElevatedButton(
              onPressed: _diceroll,
              style: ElevatedButton.styleFrom(
              backgroundColor:buttonColor,
              foregroundColor: const Color.fromARGB(255, 107, 58, 18), // Text color
              minimumSize: const Size(100, 50)
              ),
              child: const Text('Heitä noppaa', style: TextStyle(fontSize: 24)),
            ),
          ),
        ],
      ),
    );
  }
}
