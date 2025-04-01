import 'package:flutter/material.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  // Lista de mascotas
  final List<String> _pets = ['Perro', 'Gato', 'Conejo'];

  // Método para agregar una nueva mascota
  void _addPet(String petName) {
    setState(() {
      _pets.add(petName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Mis Mascotas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // Lista de mascotas
          Expanded(
            child: ListView.builder(
              itemCount: _pets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_pets[index], style: const TextStyle(fontSize: 18)),
                  trailing: Icon(Icons.pets, color: Colors.teal[400]),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showAddPetDialog(context),
            child: const Text('Agregar Mascota'),
          ),
        ],
      ),
    );
  }

  // Diálogo para agregar una nueva mascota
  void _showAddPetDialog(BuildContext context) {
    final TextEditingController petController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Mascota'),
          content: TextField(
            controller: petController,
            decoration: const InputDecoration(hintText: 'Escribe el nombre de tu mascota'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (petController.text.isNotEmpty) {
                  _addPet(petController.text);
                  petController.clear(); // Limpiar el campo después de agregar
                  Navigator.pop(context);
                }
              },
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
