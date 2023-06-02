import 'dart:typed_data';

import 'package:aplication_salesiana/models/register_student.dart';
import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/table/register_table.dart';
import 'package:aplication_salesiana/utils/pdf_templates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:io';

class RegisterDataScreen extends StatefulWidget {
  const RegisterDataScreen(
      {super.key,
      required this.turno,
      required this.periodo,
      required this.carrera,
      required this.fecha});

  final String turno;
  final String periodo;
  final String carrera;
  final DateTime fecha;

  @override
  State<RegisterDataScreen> createState() => _RegisterDataScreenState();
}

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  late ResgisterStudensProvider resgisterStudensProvider;
  List<ResgisterStudens> resgisterStudens = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      resgisterStudens =
          await Provider.of<ResgisterStudensProvider>(context, listen: false)
              .generateRegister(
                  carrera: widget.carrera,
                  turno: widget.turno,
                  periodo: widget.periodo,
                  fecha: widget.fecha);
    });

    super.initState();
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
          const SizedBox(height: 10),
          resgisterStudensProvider.isLoading
              ? const SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator())
              : SizedBox(
                  height: 200,
                  child: RegisterTable(
                    registerStudents: resgisterStudensProvider.resgisterStudens,
                  )),
          //generate pdf
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                Uint8List pdfData = await PdfTemplates.affiliationDocPdf(
                    turno: widget.turno,
                    periodo: widget.periodo,
                    carrera: widget.carrera,
                    fecha: widget.fecha,
                    resgisterStudens: resgisterStudens);
                if (kIsWeb) {
                  PdfWebService.downloadPdf(pdfData, "FichaDeAfiliacion");
                }
              },
              child: const Text('Generar PDF')),
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
