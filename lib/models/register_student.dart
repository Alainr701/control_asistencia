// To parse this JSON data, do
//
//     final resgistroStudens = resgistroStudensFromJson(jsonString);

import 'dart:convert';

class ResgisterStudens {
  String carrera;
  String id;
  String paralelo;
  String docente;
  DateTime fecha;
  int nroEstudiantes;
  int nroTotalEstudiantes;
  String nroAula;
  bool asistencia;
  String turno;
  String periodo;

  ResgisterStudens({
    required this.id,
    required this.carrera,
    required this.paralelo,
    required this.docente,
    required this.fecha,
    required this.nroEstudiantes,
    required this.nroTotalEstudiantes,
    required this.nroAula,
    required this.asistencia,
    required this.turno,
    required this.periodo,
  });

  factory ResgisterStudens.fromRawJson(String str) =>
      ResgisterStudens.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResgisterStudens.fromJson(Map<String, dynamic> json) =>
      ResgisterStudens(
        id: json["id"],
        carrera: json["carrera"],
        paralelo: json["paralelo"],
        docente: json["docente"],
        fecha: json["fecha"]?.toDate(),
        nroEstudiantes: json["nro_estudiante"],
        nroTotalEstudiantes: json["nro_total_estudiantes"],
        nroAula: json["nro_aula"],
        asistencia: json["asistencia"],
        turno: json["turno"],
        periodo: json["periodo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carrera": carrera,
        "paralelo": paralelo,
        "docente": docente,
        "fecha": fecha,
        "nro_estudiante": nroEstudiantes,
        "nro_total_estudiantes": nroTotalEstudiantes,
        "nro_aula": nroAula,
        "asistencia": asistencia,
        "turno": turno,
        "periodo": periodo,
      };
}
