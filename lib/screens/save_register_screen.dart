import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/table/register_table.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ResgisterStudensProvider>(context, listen: false)
          .getRegisters(
              carrera: widget.carrera,
              turno: widget.turno,
              periodo: widget.periodo);
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
                  ))
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
