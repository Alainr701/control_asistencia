import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/widgets/custom_button.dart';
import 'package:aplication_salesiana/widgets/string_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTableScreen extends StatefulWidget {
  const CreateTableScreen({super.key});

  @override
  State<CreateTableScreen> createState() => _CreateTableScreenState();
}

class _CreateTableScreenState extends State<CreateTableScreen> {
  late ResgisterStudens? registerStudens;
  //  ResgisterStudens(id: id, carrera: carrera,
  //  paralelo: paralelo,
  //   docente: docente,
  //    fecha: fecha,
  //     nroEstudiantes: nroEstudiantes,
  //      nroAula: nroAula,
  //       asistencia: asistencia,
  //        turno: turno,
  //         periodo: periodo);
  // final carreraController = TextEditingController();
  DateTime? selectedDate;
  late ResgisterStudensProvider registerStudensProvider;

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

  final paraleloController = TextEditingController();
  final docenteController = TextEditingController();
  final fechaController = TextEditingController();
  final nroEstudiantesController = TextEditingController();
  final nroAulaController = TextEditingController();
  final asistenciaController = TextEditingController();
  final turnoController = TextEditingController();
  final periodoController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    registerStudensProvider =
        Provider.of<ResgisterStudensProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Archivo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
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
          //button Editar
          // _buildTitle('Editar'),
          // const SizedBox(height: 5),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: isEdit ? Colors.blue : Colors.grey,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       isEdit = !isEdit;
          //     });
          //   },
          //   child: const Text('Editar'),
          // ),
          //FECHA
          // _buildTitle('Fecha'),
          // const SizedBox(height: 5),
          // TextFormField(
          //   controller: fechaController,
          //   decoration: const InputDecoration(
          //     hintText: 'Fecha',
          //     border: OutlineInputBorder(),
          //     prefixIcon: Icon(Icons.calendar_today),
          //   ),
          //   onTap: () async {
          //     selectedDate = await showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime(2020),
          //       lastDate: DateTime(2025),
          //     );
          //     if (selectedDate != null) {
          //       fechaController.text =
          //           DateFormat('dd-MM-yyyy').format(selectedDate!);
          //     }
          //   },
          // ),
          const SizedBox(height: 10),
          _buildTitle('Paralelo'),
          const SizedBox(height: 5),
          TextFormField(
            controller: paraleloController,
            decoration: const InputDecoration(
              hintText: 'Paralelo',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
            ),
          ),
          const SizedBox(height: 10),
          _buildTitle('Docente'),
          const SizedBox(height: 5),
          TextFormField(
            controller: docenteController,
            decoration: const InputDecoration(
              hintText: 'Docente',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 10),
          _buildTitle('Nro. Estudiantes'),
          const SizedBox(height: 5),
          TextFormField(
            controller: nroEstudiantesController,
            decoration: const InputDecoration(
              hintText: 'Nro. Total  de Estudiantes',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.people),
            ),
          ),
          const SizedBox(height: 10),
          _buildTitle('Aula'),
          const SizedBox(height: 5),
          TextFormField(
            controller: nroAulaController,
            decoration: const InputDecoration(
              hintText: 'Aula',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
            ),
          ),
          const SizedBox(height: 10),

          Center(
            child: CustomButton(
                text: isEdit ? 'ACTUALIZAR' : 'CREAR',
                onPressed: () {
                  if (paraleloController.text.isEmpty ||
                      docenteController.text.isEmpty ||
                      nroEstudiantesController.text.isEmpty ||
                      nroAulaController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Llene todos los campos'),
                      ),
                    );
                    return;
                  }
                  if (isEdit) {
                    registerStudensProvider.updateRegister(ResgisterStudens(
                      id: '',
                      carrera: carrera,
                      paralelo: paraleloController.text,
                      docente: docenteController.text,
                      fecha: DateTime.now(),
                      nroEstudiantes: 0,
                      nroTotalEstudiantes:
                          int.parse(nroEstudiantesController.text),
                      nroAula: nroAulaController.text,
                      asistencia: false,
                      turno: turno,
                      periodo: periodo,
                    ));
                    return;
                  }

                  registerStudensProvider
                      .createRegisterTableForPermanenty(ResgisterStudens(
                    id: '',
                    carrera: carrera,
                    paralelo: paraleloController.text,
                    docente: docenteController.text,
                    fecha: DateTime.now(),
                    nroEstudiantes: 0,
                    nroTotalEstudiantes:
                        int.parse(nroEstudiantesController.text),
                    nroAula: nroAulaController.text,
                    asistencia: false,
                    turno: turno,
                    periodo: periodo,
                  ));
                  //CLEAR

                  paraleloController.clear();
                  docenteController.clear();
                  nroEstudiantesController.clear();
                  nroAulaController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registro creado'),
                    ),
                  );
                }),
          )
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
