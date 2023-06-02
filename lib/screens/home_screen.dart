import 'package:aplication_salesiana/screens/create_register_screen.dart';
import 'package:aplication_salesiana/screens/perfil_screen.dart';
import 'package:aplication_salesiana/screens/registro_screen.dart';
import 'package:aplication_salesiana/screens/create_table_screen.dart';
import 'package:aplication_salesiana/services/auth_methods.dart';
import 'package:aplication_salesiana/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Pagina Principal', style: TextStyle(fontSize: 20)),
      ),
      //drawer con perfil
      drawer: _buildDrawer(context),
      body: _buildBodyInicio(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBodyInicio(BuildContext context) {
    if (_currentIndex == 1) return const PerfilScreen();
    return ListView(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/banner.jpg'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Divider(height: 20, thickness: 2, indent: 20, endIndent: 20),
        CustomContainer(
          text: 'Iniciar Registro',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const RegistroScreen()));
          },
        ),
        const Divider(height: 20, thickness: 2, indent: 20, endIndent: 20),
        CustomContainer(
            text: 'Generar Registro',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const GenerateRegistroDateScreen()));
            }),
        const Divider(height: 20, thickness: 2, indent: 20, endIndent: 20),
        CustomContainer(
            text: 'Crear Registro',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CreateTableScreen()));
            }),
      ],
    );
  }

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0D428A),
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/GEO.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            // BoxDecoration(color: Color.fromARGB(255, 173, 171, 171)),
            accountName: Text('Nombre: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            accountEmail: Text('Correo: ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color(0xFF0D428A),
              child: Text('A'),
            ),
          ),
          ListTile(
            title: const Text('Perfil', style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.person, color: Colors.white),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegistroScreen()));
            },
          ),
          ListTile(
            title: const Text('Cerrar Sesion',
                style: TextStyle(color: Colors.white)),
            leading: const Icon(Icons.logout, color: Colors.white),
            onTap: () {
              AuthMethods().signOut();
            },
          ),
        ],
      ),
    );
  }
}
