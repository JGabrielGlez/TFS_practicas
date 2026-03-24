//Daniel Barrera
//Gabriel González

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Equipo Robles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: PantallaLogin(),
    );
  }
}

class PantallaLogin extends StatefulWidget {
  PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final correoCtrl = TextEditingController();
  final contraCtrl = TextEditingController();

  bool login = true;

  Future<void> submit() async {
    try {
      final conexion = FirebaseAuth.instance;
      if (login) {
        await conexion.signInWithEmailAndPassword(
          email: correoCtrl.text,
          password: contraCtrl.text,
        );
      } else {
        await conexion.createUserWithEmailAndPassword(
          email: correoCtrl.text,
          password: contraCtrl.text,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Éxito")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.perm_phone_msg, size: 80, color: Colors.black),
                Text(
                  login ? "Bienvenido" : "Registro",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: correoCtrl,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contraCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",

                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: submit,
                    child: Text(login ? "Ingresar" : "Crear cuenta"),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => login = !login),
                  child: Text(
                    login
                        ? "¿No tienes cuenta? Crea una"
                        : "¿Ya tienes cuenta? Ingresa",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Firebase inicializado correctamente')),
    );
  }
}
