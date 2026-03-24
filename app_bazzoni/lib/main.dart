//DAM: Abisaí Ruiz
//TFS:Gabriel Gonzalez
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Carrusel app",

      home: const Carrusel(),
    );
  }
}

class Carrusel extends StatefulWidget {
  const Carrusel({super.key});

  @override
  State<Carrusel> createState() => _CarruselState();
}

class _CarruselState extends State<Carrusel> {
  int currentIndex = 0;

  final List<String> images = List.generate(
    3,
    (index) => 'assets/img${index + 1}.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Carrusel de imagenes",
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text(
                  "Imagen ${currentIndex + 1}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  images[currentIndex],
                  height: 400,
                  width: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / images.length,
                    minHeight: 1,
                    backgroundColor: Colors.grey[300],
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 145),
            child: Row(
              children: [
                TextButton(
                  onPressed: retrocederCarrusel,
                  child: const Text("Retroceder"),
                ),
                TextButton(
                  onPressed: avanzarCarrusel,
                  child: const Text("Avanzar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void avanzarCarrusel() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }

  void retrocederCarrusel() {
    setState(() {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
    });
  }
}
