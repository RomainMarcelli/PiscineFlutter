import 'package:flutter/material.dart';

enum Operation { add, sub, mul, div }

class SimpleCalculatorPage extends StatefulWidget {
  const SimpleCalculatorPage({super.key});

  @override
  State<SimpleCalculatorPage> createState() => _SimpleCalculatorPageState();
}

class _SimpleCalculatorPageState extends State<SimpleCalculatorPage> {
  final _n1Ctrl = TextEditingController();
  final _n2Ctrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Operation _op = Operation.add;
  String? _result;

  @override
  void dispose() {
    _n1Ctrl.dispose();
    _n2Ctrl.dispose();
    super.dispose();
  }

  double _parseNum(String s) => double.parse(s.trim().replaceAll(',', '.'));

  String? _validator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Champ requis';
    final t = v.trim().replaceAll(',', '.');
    if (double.tryParse(t) == null) return 'Nombre invalide';
    return null;
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final a = _parseNum(_n1Ctrl.text);
    final b = _parseNum(_n2Ctrl.text);

    double res;
    switch (_op) {
      case Operation.add:
        res = a + b;
      case Operation.sub:
        res = a - b;
      case Operation.mul:
        res = a * b;
      case Operation.div:
        if (b == 0) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Division par zéro')));
          return;
        }
        res = a / b;
    }

    // Affiche entier sans décimales, sinon 2 décimales
    final text = res.truncateToDouble() == res
        ? res.toStringAsFixed(0)
        : res.toStringAsFixed(2);

    setState(() => _result = text);
  }

  Widget _radio(Operation value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Operation>(
          value: value,
          groupValue: _op,
          onChanged: (v) => setState(() => _op = v!),
        ),
        Text(label),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _n1Ctrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nombre 1',
                ),
                validator: _validator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _n2Ctrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nombre 2',
                ),
                validator: _validator,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Radios alignées sur une ligne (Wrap pour retour à la ligne si écran étroit)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _radio(Operation.add, 'Addition'),
                  _radio(Operation.sub, 'Soustraction'),
                  _radio(Operation.mul, 'Multiplication'),
                  _radio(Operation.div, 'Division'),
                ],
              ),
              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: _calculate,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('Calculer'),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (_result != null)
                Center(
                  child: Text(
                    'Résultat : $_result',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
  