import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Icon(transaction["icon"], color: Colors.purple),
            title: Text(transaction["title"],
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(
              (transaction["amount"] > 0 ? "+₹" : "-₹") +
                  transaction["amount"].abs().toString(),
              style: TextStyle(
                color: transaction["amount"] > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
