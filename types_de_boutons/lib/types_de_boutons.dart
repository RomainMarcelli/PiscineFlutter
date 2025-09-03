import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page Exercice 1 : Types de boutons
class TypesDeBoutonsPage extends StatefulWidget {
  const TypesDeBoutonsPage({super.key});

  @override
  State<TypesDeBoutonsPage> createState() => _TypesDeBoutonsPageState();
}

class _TypesDeBoutonsPageState extends State<TypesDeBoutonsPage> {
  String? _selectedOption;

  // Affiche un SnackBar avec le libellé cliqué
  void _showSnack(String label) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Vous avez cliqué sur : $label'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types de boutons en Flutter'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton (forme pilule)
              ElevatedButton(
                onPressed: () => _showSnack('Elevated Button'),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: const Text('Elevated Button'),
              ),
              const SizedBox(height: 12),

              // TextButton
              TextButton(
                onPressed: () => _showSnack('Text Button'),
                child: const Text('Text Button'),
              ),
              const SizedBox(height: 12),

              // OutlinedButton (forme pilule)
              OutlinedButton(
                onPressed: () => _showSnack('Outlined Button'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26, width: 1.2),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
                child: const Text('Outlined Button'),
              ),
              const SizedBox(height: 20),

              // Icône cœur (grand, rouge)
              GestureDetector(
                onTap: () => _showSnack('Icône cœur'),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 56,
                ),
              ),
              const SizedBox(height: 16),

              // Bouton + carré avec ombre (style FAB)
              SizedBox(
                height: 56,
                width: 56,
                child: FloatingActionButton.small(
                  heroTag: 'inlineFab',
                  onPressed: () => _showSnack('Bouton +'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 24),

              // Dropdown "Select an option"
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedOption,
                  hint: const Text('Select an option'),
                  items: const [
                    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                    DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                    DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedOption = value);
                    _showSnack('Dropdown: ${value ?? ''}');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Cupertino button bleu plein
              SizedBox(
                width: 260,
                child: CupertinoButton.filled(
                  onPressed: () => _showSnack('Cupertino Button'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: const Text('Cupertino Button'),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF7F1F6),
    );
  }
}
