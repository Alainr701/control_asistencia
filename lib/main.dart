import 'package:aplication_salesiana/providers/auth_provider.dart';
import 'package:aplication_salesiana/providers/register_students.dart';
import 'package:aplication_salesiana/screens/home_screen.dart';
import 'package:aplication_salesiana/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCbR2RdUU2cYhypmLOT2w7GDUnNmPesYm8",
          authDomain: "salesiana-proyecto.firebaseapp.com",
          projectId: "salesiana-proyecto",
          storageBucket: "salesiana-proyecto.appspot.com",
          messagingSenderId: "674611013249",
          databaseURL:
              'https://salesiana-proyecto-default-rtdb.firebaseio.com/',
          appId: "1:674611013249:web:260f701156c1c7ac428f80"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<ResgisterStudensProvider>(
            create: (_) => ResgisterStudensProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D428A),
          //bottom navigation bar color
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 252, 252, 251),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0D428A),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
