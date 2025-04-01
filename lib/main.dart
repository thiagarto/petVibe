import 'package:flutter/material.dart';
import 'dart:async'; // Importar Timer
import 'screens/pets_screen.dart'; // Asegúrate de tener importado PetsScreen

void main() {
  runApp(const PetVibeApp());
}

class PetVibeApp extends StatelessWidget {
  const PetVibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetVibe',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

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
  Timer? _timer; // Usar Timer como una variable de instancia

  @override
  void dispose() {
    // Cancelar el Timer cuando el widget sea destruido
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_currentIconIndex >= _pawIcons.length - 1) {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _currentIconIndex = (_currentIconIndex + 1) % _pawIcons.length;
        });
      }
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Aquí ya no ponemos `const` en los StatefulWidgets
  static List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Inicio', style: TextStyle(fontSize: 18, color: Colors.white))),
    PetsScreen(), // Aquí ya no es const
    const Center(child: Text('Calendario', style: TextStyle(fontSize: 18, color: Colors.white))),
    const Center(child: Text('Perfil', style: TextStyle(fontSize: 18, color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[900],
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
