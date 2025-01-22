import 'dart:math';
import 'package:flutter/material.dart';

const Color diceAppYellow = Color.fromARGB(255, 241, 229, 190);
const Color diceAppBrown = Color.fromARGB(255, 107, 58, 18);

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  var numberOfDice = 1;
  late List<int> _rolls;
  late List<bool> _isLocked; // Save the locked state of each die

  @override
  void initState() {
    super.initState();
    _rolls = List.generate(numberOfDice, (index) => 1);
    _isLocked = List.generate(numberOfDice, (index) => false); // Initialize all dice as unlocked
  }

  void _diceroll() {
    setState(() {
      for (int i = 0; i < _rolls.length; i++) {
        if (!_isLocked[i]) {
          // Roll the die if it is not locked
          _rolls[i] = Random().nextInt(6) + 1;
        }
      }
    });
  }

  void _updateDiceCount(int change) {
    setState(() {
      numberOfDice = (numberOfDice + change).clamp(1, 12); // Limit the number of dice to 1-12
      _rolls = List.generate(numberOfDice, (index) => 1); // Roll new dice
      _isLocked = List.generate(numberOfDice, (index) => false); // Remove all locks when changing the number of dice
    });
  }

  void _toggleLock(int index) {
    setState(() {
      _isLocked[index] = !_isLocked[index]; // Toggle the lock state of the die
    });
  }

  void _clearSelections() {
    setState(() {
      _isLocked = List.generate(numberOfDice, (index) => false); // Unlock all dice
    });
  }

  // Build buttons to increase or decrease the number of dice
  Widget _buildDiceControlButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Container(
        decoration: BoxDecoration(
          color: diceAppYellow,
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
    );
  }

  // Build a button to clear all locked dice
  Widget _buildClearSelectionButton() {
    if (!_isLocked.contains(true)) return const SizedBox.shrink();

    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Center(
        child: ElevatedButton(
          onPressed: _clearSelections,
          style: ElevatedButton.styleFrom(
            backgroundColor: diceAppYellow,
            shape: const CircleBorder(),
            minimumSize: const Size(60, 60),
          ),
          child: const Icon(
            Icons.lock_open,
            size: 30,
            color: diceAppBrown,
          ),
        ),
      ),
    );
  }

  //Build dice images
  Widget _buildDiceGrid() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 280,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(_rolls.length, (index) {
            return GestureDetector(
              onTap: () => _toggleLock(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: _isLocked[index]
                        ? Colors.red
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/dice${_rolls[index]}.png',
                    fit: BoxFit.contain,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Build a button to roll the dice
  Widget _buildRollDiceButton() {
    return ElevatedButton(
      onPressed: _diceroll,
      style: ElevatedButton.styleFrom(
        backgroundColor: diceAppYellow,
        foregroundColor: diceAppBrown,
        minimumSize: const Size(100, 50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: -pi / 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), // Slightly curve the die image edges
              child: Image.asset(
                'assets/images/dice2.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Transform.rotate(
            angle: pi / 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), // Slightly curve the die image edges
              child: Image.asset(
                'assets/images/dice5.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildDiceControlButtons(),
              Expanded(child: _buildDiceGrid()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: _buildRollDiceButton(),
              ),
            ],
          ),
          _buildClearSelectionButton(),
        ],
      ),
    );
  }
}