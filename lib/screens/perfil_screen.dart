import 'package:aplication_salesiana/models/usuario.dart';
import 'package:aplication_salesiana/services/auth_methods.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Usuario? usuario;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String correo = await AuthMethods().getUserEmail();
      usuario = await AuthMethods().getUserDetails(correo);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //crea un perfil de usuario que tenga un avatar centreado y abajo los datos del usuario (Nombre, Apellido, Correo y Cedula ,  ,en ese orden)
          //y un boton de cerrar sesion
          const Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Nombre:  ${usuario?.nombre ?? ''}}',
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Apellido:  ${usuario?.apellido ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Correo:  ${usuario?.correo ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Cedula:    ${usuario?.cedula ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Telefono:  ${usuario?.telefono ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5)),
            child: Text(
              'Correo:  ${usuario?.correo ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
