import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _n1Ctrl = TextEditingController();
  final _n2Ctrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Mets à true pour la consigne 2 (résultat sous les champs)
  bool _showResultBelow = false;
  String? _resultText;

  @override
  void dispose() {
    _n1Ctrl.dispose();
    _n2Ctrl.dispose();
    super.dispose();
  }

  double _parse(String s) => double.parse(s.replaceAll(',', '.'));

  void _compute(String op) {
    if (!_formKey.currentState!.validate()) return;

    final a = _parse(_n1Ctrl.text);
    final b = _parse(_n2Ctrl.text);

    double res;
    switch (op) {
      case '+':
        res = a + b;
        break;
      case '-':
        res = a - b;
        break;
      case '×':
        res = a * b;
        break;
      case '÷':
        if (b == 0) {
          _showError('Division par zéro');
          return;
        }
        res = a / b;
        break;
      default:
        return;
    }

    final text = res.toStringAsFixed(res.truncateToDouble() == res ? 0 : 2);

    if (_showResultBelow) {
      // ✅ Consigne 2 : afficher sous les champs
      setState(() => _resultText = text);
    } else {
      // ✅ Consigne 1 : boîte de dialogue
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Résultat'),
          content: Text(text, style: const TextStyle(fontSize: 20)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
          ],
        ),
      );
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  String? _validator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Champ requis';
    final val = v.trim().replaceAll(',', '.');
    if (double.tryParse(val) == null) return 'Nombre invalide';
    return null;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Afficher le résultat sous les champs'),
                subtitle: const Text('(désactive = montrer dans une boîte de dialogue)'),
                value: _showResultBelow,
                onChanged: (v) => setState(() {
                  _showResultBelow = v;
                  if (!v) _resultText = null;
                }),
              ),
              const SizedBox(height: 8),

              const Text('Nombre 1'),
              TextFormField(
                controller: _n1Ctrl,
                keyboardType: TextInputType.number,
                validator: _validator,
                decoration: const InputDecoration(
                  hintText: 'Entrez un nombre',
                ),
              ),
              const SizedBox(height: 16),

              const Text('Nombre 2'),
              TextFormField(
                controller: _n2Ctrl,
                keyboardType: TextInputType.number,
                validator: _validator,
                decoration: const InputDecoration(
                  hintText: 'Entrez un nombre',
                ),
              ),
              const SizedBox(height: 16),

              if (_showResultBelow && _resultText != null) ...[
                const Text('Résultat', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(_resultText!, style: const TextStyle(fontSize: 22)),
                const SizedBox(height: 8),
              ],

              // Barre de boutons d'opérations
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _opButton('Addition', () => _compute('+')),
                  _opButton('Soustraction', () => _compute('-')),
                  _opButton('Multiplication', () => _compute('×')),
                  _opButton('Division', () => _compute('÷')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _opButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
