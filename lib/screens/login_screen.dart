import 'package:aplication_salesiana/providers/auth_provider.dart';
import 'package:aplication_salesiana/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color primary = Color(0xFF00409C);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const Spacer(),
                  _buildImageCenter(),
                  const Spacer(),
                  _buildEmail(),
                  const SizedBox(height: 20),
                  _buildPassword(),
                  const SizedBox(height: 50),
                  _buildEnter(),
                  const Spacer(flex: 2)
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  SizedBox _buildImageCenter() {
    return const SizedBox(
        height: 200,
        width: 200,
        child:
            Image(image: AssetImage('assets/sale2.jpg'), fit: BoxFit.contain));
  }

  navigatorPush() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  ElevatedButton _buildEnter() {
    return ElevatedButton(
      onPressed: () async {
        bool res = await authProvider.loginUser(
            _emailController.text.trim(), _passwordController.text.trim());
        print(res);
        // if (res) navigatorPush();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: primary)))),
      child: Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          child: const Text('Ingresar')),
    );
  }

  TextFormField _buildPassword() {
    return TextFormField(
      cursorColor: Colors.black,
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Contraseña', style: TextStyle(color: primary))),
    );
  }

  TextFormField _buildEmail() {
    return TextFormField(
      cursorColor: Colors.black,
      controller: _emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Email', style: TextStyle(color: primary))),
    );
  }
}
