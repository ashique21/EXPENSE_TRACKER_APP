import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double totalIncome;
  final double totalExpenses;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Balance",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 5),
          Text(
            "₹${totalBalance.toStringAsFixed(2)}", // Display the total balance
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Income: ₹${totalIncome.toStringAsFixed(2)}", // Display the total income
                style: TextStyle(color: Colors.green[200], fontSize: 16),
              ),
              Text(
                "Expenses: ₹${totalExpenses.toStringAsFixed(2)}", // Display the total expenses
                style: TextStyle(color: Colors.red[200], fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
