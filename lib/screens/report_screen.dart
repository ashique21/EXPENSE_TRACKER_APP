import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const ReportScreen({super.key, required this.transactions});

  Map<String, double> calculateCategoryTotals() {
    double totalIncome = 0;
    double totalExpense = 0;

    for (var transaction in transactions) {
      if (transaction['amount'] > 0) {
        totalIncome += transaction['amount'];
      } else {
        totalExpense += transaction['amount'].abs();
      }
    }

    return {
      'Income': totalIncome,
      'Expense': totalExpense,
    };
  }

  Map<String, double> calculateExpenseByCategory() {
    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction['amount'] < 0) {
        String category = transaction['name'] ?? 'Unnamed';
        categoryTotals[category] =
            (categoryTotals[category] ?? 0) + transaction['amount'].abs();
      }
    }

    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotals = calculateCategoryTotals();
    final expenseByCategory = calculateExpenseByCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income vs Expense',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: categoryTotals['Income'],
                      title:
                          'Income\n₹${categoryTotals['Income']!.toStringAsFixed(2)}',
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: categoryTotals['Expense'],
                      title:
                          'Expense\n₹${categoryTotals['Expense']!.toStringAsFixed(2)}',
                      radius: 80,
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Expenses by Category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenseByCategory.length,
                itemBuilder: (context, index) {
                  String category = expenseByCategory.keys.elementAt(index);
                  double amount = expenseByCategory[category]!;
                  return ListTile(
                    leading: Icon(Icons.label, color: Colors.purple),
                    title: Text(category),
                    trailing: Text('₹${amount.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
