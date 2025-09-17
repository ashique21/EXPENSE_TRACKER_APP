import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isIncome = true;

  void _submitData() async {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isEmpty || amount <= 0) return;

    final transaction = {
      'id': DateTime.now().toString(),
      'title': title,
      'amount': _isIncome
          ? amount
          : -amount, // Positive for income, negative for expense
      'isIncome': _isIncome,
      'date': DateTime.now().toIso8601String(),
    };

    final transactionsBox = await Hive.openBox('transactions');
    await transactionsBox.add(transaction);

    Navigator.pop(context); // Close the screen after adding the transaction
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: const Text('Income'),
              value: _isIncome,
              onChanged: (value) {
                setState(() {
                  _isIncome = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
