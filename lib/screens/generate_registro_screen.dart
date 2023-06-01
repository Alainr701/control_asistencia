import 'package:aplication_salesiana/screens/generate_register_screen.dart';
import 'package:aplication_salesiana/screens/save_register_screen.dart';
import 'package:aplication_salesiana/widgets/custom_button.dart';
import 'package:aplication_salesiana/widgets/string_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenerateRegistroScreen extends StatefulWidget {
  const GenerateRegistroScreen({super.key});

  @override
  State<GenerateRegistroScreen> createState() => _GenerateRegistroScreenState();
}

class _GenerateRegistroScreenState extends State<GenerateRegistroScreen> {
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
  final textDateController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Generar Registro', style: TextStyle(fontSize: 20)),
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
          //FECHA
          _buildTitle('Fecha'),
          const SizedBox(height: 5),
          TextFormField(
            controller: textDateController,
            decoration: const InputDecoration(
              hintText: 'Fecha',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              );
              if (selectedDate != null) {
                textDateController.text =
                    DateFormat('dd-MM-yyyy').format(selectedDate!);
              }
            },
          ),

          const SizedBox(height: 30),
          CustomButton(
              text: 'GENERAR',
              onPressed: () {
                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Seleccione una fecha'),
                    ),
                  );
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GeneratedReScreen(
                              carrera: carrera,
                              periodo: periodo,
                              turno: turno,
                              fecha: selectedDate!,
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
