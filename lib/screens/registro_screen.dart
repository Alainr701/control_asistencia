import 'package:aplication_salesiana/screens/save_register_screen.dart';
import 'package:aplication_salesiana/widgets/custom_button.dart';
import 'package:aplication_salesiana/widgets/string_dropdown.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  List<String> carreras = [
    'Psicomotricidad',
    'Ingeniería de Sistemas',
    'Contaduría Pública',
    'Derecho',
    'Ingeniería Comercial y Desarrollo de Negocios',
    'Gastronomía y Gestión de Restaurantes '
  ];
  List<String> turnos = ['Mañana', 'Tarde', 'Noche'];
  List<String> periodos = ['7:30 a 9:00', '9:15 a 10:45', '11:00 a 12:30'];

  String turno = 'Mañana';
  String periodo = '7:30 a 9:00';
  String carrera = 'Psicomotricidad';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Menu', style: TextStyle(fontSize: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 30),
          _buildTitle('Turno'),
          const SizedBox(height: 5),
          StringDropdown(
              values: turnos,
              initialValue: turno,
              onChanged: (val) {
                turno = val!;
              },
              selectedColor: Colors.blue.shade400),
          const SizedBox(height: 10),
          _buildTitle('Periodo'),
          const SizedBox(height: 5),
          StringDropdown(
              values: periodos,
              initialValue: periodo,
              onChanged: (val) {
                periodo = val!;
              },
              selectedColor: Colors.blue.shade400),
          const SizedBox(height: 10),
          _buildTitle('Carrera'),
          const SizedBox(height: 5),
          StringDropdown(
              values: carreras,
              initialValue: carrera,
              onChanged: (val) {
                carrera = val!;
              },
              selectedColor: Colors.blue.shade400),
          const SizedBox(height: 10),
          CustomButton(
              text: 'INICIAR',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SaveRegisterScreen(
                              carrera: carrera,
                              periodo: periodo,
                              turno: turno,
                            )));
              })
        ],
      ),
    );
  }

  Text _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
