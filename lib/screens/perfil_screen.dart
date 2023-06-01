import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        //crea un perfil de usuario que tenga un avatar centreado y abajo los datos del usuario (Nombre, Apellido, Correo y Cedula ,  ,en ese orden)
        //y un boton de cerrar sesion
        const SizedBox(height: 5),
        Center(
          child: CircleAvatar(
            radius: 50,
            child: const Icon(Icons.person, size: 50),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Nombre',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Apellido',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Correo',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Cedula',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Telefono',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'Correo',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
