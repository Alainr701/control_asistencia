import 'dart:convert';

class Usuario {
  final String? id;
  final String nombre;
  final String apellido;
  final String cedula;
  final String correo;
  final String telefono;

  Usuario({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.correo,
    required this.telefono,
  });
  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        cedula: json["cedula"],
        correo: json["correo"],
        telefono: json["telefono"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "cedula": cedula,
        "correo": correo,
        "telefono": telefono,
      };
}
