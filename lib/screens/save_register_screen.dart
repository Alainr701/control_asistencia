import 'dart:convert';

import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/table/register_table.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SaveRegisterScreen extends StatefulWidget {
  const SaveRegisterScreen(
      {super.key,
      required this.turno,
      required this.periodo,
      required this.carrera});

  final String turno;
  final String periodo;
  final String carrera;

  @override
  State<SaveRegisterScreen> createState() => _SaveRegisterScreenState();
}

class _SaveRegisterScreenState extends State<SaveRegisterScreen> {
  late ResgisterStudensProvider resgisterStudensProvider;
  int totalEstudiantes = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ResgisterStudensProvider>(context, listen: false)
          .getRegisterTable(
              carrera: widget.carrera,
              turno: widget.turno,
              periodo: widget.periodo);
      List.generate(resgisterStudensProvider.resgisterStudensTable.length,
          (index) async {
        await resgisterStudensProvider.createRegisterTable(ResgisterStudens(
          id: resgisterStudensProvider.resgisterStudensTable[index].id,
          carrera:
              resgisterStudensProvider.resgisterStudensTable[index].carrera,
          paralelo:
              resgisterStudensProvider.resgisterStudensTable[index].paralelo,
          docente:
              resgisterStudensProvider.resgisterStudensTable[index].docente,
          fecha: DateTime.now(),
          nroEstudiantes: resgisterStudensProvider
              .resgisterStudensTable[index].nroEstudiantes,
          nroTotalEstudiantes: resgisterStudensProvider
              .resgisterStudensTable[index].nroTotalEstudiantes,
          nroAula:
              resgisterStudensProvider.resgisterStudensTable[index].nroAula,
          asistencia:
              resgisterStudensProvider.resgisterStudensTable[index].asistencia,
          turno: resgisterStudensProvider.resgisterStudensTable[index].turno,
          periodo:
              resgisterStudensProvider.resgisterStudensTable[index].periodo,
        ));
      });
    });
    try {
      final databaseReference = FirebaseDatabase.instance.ref().child('test');

      DatabaseReference starCountRef = databaseReference;
      starCountRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        convertToJSON(data);
      });
    } catch (e) {
      print('Error: $e');
    }

    super.initState();
  }

  void convertToJSON(dynamic data) {
    String jsonData = jsonEncode(data);
    print('Datos en formato JSON: $jsonData');
    final jsonResult = jsonDecode(jsonData);
    totalEstudiantes = jsonResult.length;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    resgisterStudensProvider =
        Provider.of<ResgisterStudensProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Registrar', style: TextStyle(fontSize: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 30),
          Row(children: [
            _buildText('Fecha: ', Colors.blue),
            _buildText(
                DateFormat('dd-MM-yyyy').format(DateTime.now()), Colors.black),
            const Spacer(),
            _buildText('Carrera: ', Colors.blue),
            _buildText(widget.carrera, Colors.black),
          ]),
          const SizedBox(height: 10),
          _buildText('Turno: ', Colors.blue),
          _buildText(widget.turno, Colors.black),
          _buildText('Periodo: ', Colors.blue),
          _buildText(widget.periodo, Colors.black),
          _buildText('Total Estudiantes: ', Colors.blue),
          _buildText(totalEstudiantes.toString(), Colors.black),
          const SizedBox(height: 10),

          resgisterStudensProvider.isLoading
              ? const SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator())
              : SizedBox(
                  height: 200,
                  child: RegisterTable(
                    registerStudents:
                        resgisterStudensProvider.resgisterStudensTable,
                  )),
          const SizedBox(height: 10),
          //elevated button
          ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Guardando...'),
                ),
              );
              await resgisterStudensProvider.createRegisterTable(
                ResgisterStudens(
                  id: resgisterStudensProvider.resgisterStudensTable[0].id,
                  carrera:
                      resgisterStudensProvider.resgisterStudensTable[0].carrera,
                  paralelo: resgisterStudensProvider
                      .resgisterStudensTable[0].paralelo,
                  docente:
                      resgisterStudensProvider.resgisterStudensTable[0].docente,
                  fecha: DateTime.now(),
                  nroEstudiantes: resgisterStudensProvider
                      .resgisterStudensTable[0].nroEstudiantes,
                  nroTotalEstudiantes: resgisterStudensProvider
                      .resgisterStudensTable[0].nroTotalEstudiantes,
                  nroAula:
                      resgisterStudensProvider.resgisterStudensTable[0].nroAula,
                  asistencia: resgisterStudensProvider
                      .resgisterStudensTable[0].asistencia,
                  turno:
                      resgisterStudensProvider.resgisterStudensTable[0].turno,
                  periodo:
                      resgisterStudensProvider.resgisterStudensTable[0].periodo,
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Text _buildText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
