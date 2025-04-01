import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<IconData> _pawIcons = [
    Icons.pets,
    Icons.pets,
    Icons.pets,
    Icons.pets,
  ];

  int _currentIconIndex = 0;

  void _startAnimation() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_currentIconIndex >= _pawIcons.length - 1) {
        timer.cancel();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
      setState(() {
        _currentIconIndex = (_currentIconIndex + 1) % _pawIcons.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _pawIcons[_currentIconIndex],
              size: 80,
              color: Colors.teal[400],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a PetVibe 🐾',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Conéctate con tu mascota de una manera única',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startAnimation,
              child: const Text('Empezar'),
            ),
          ],
        ),
      ),
    );
  }
}
