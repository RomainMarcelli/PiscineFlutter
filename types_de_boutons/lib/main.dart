import 'package:flutter/material.dart';

// ⚡️ importe tes fichiers
import 'types_de_boutons.dart';
import 'calculator_page.dart';
// import 'exo3.dart'; // tu pourras ajouter ton 3ème fichier plus tard

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mes exercices Flutter',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercices Flutter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TypesDeBoutonsPage()),
                );
              },
              child: const Text("Exercice 1 : Types de boutons"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CalculatorPage()),
                );
              },
              child: const Text("Exercice 2 : Calculatrice"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: remplacer par ta 3ème page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Exercice 3 pas encore dispo")),
                );
              },
              child: const Text("Exercice 3 : À venir"),
            ),
          ],
        ),
      ),
    );
  }
}
