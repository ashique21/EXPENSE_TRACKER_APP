import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_list.dart';
import 'add_transaction_screen.dart';
import 'report_screen.dart';
import 'profile_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  final Box transactionsBox;

  const HomeScreen({super.key, required this.transactionsBox});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box get transactionsBox => widget.transactionsBox;

  double get totalBalance {
    double balance = 0.0;
    for (var transaction in transactionsBox.values) {
      balance += (transaction['amount'] ?? 0);
    }
    return balance;
  }

  double get totalIncome {
    double income = 0.0;
    for (var transaction in transactionsBox.values) {
      if ((transaction['amount'] ?? 0) > 0) {
        income += transaction['amount'];
      }
    }
    return income;
  }

  double get totalExpenses {
    double expenses = 0.0;
    for (var transaction in transactionsBox.values) {
      if ((transaction['amount'] ?? 0) < 0) {
        expenses += transaction['amount'];
      }
    }
    return expenses.abs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: transactionsBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No transactions yet."));
          }

          List<Map<String, dynamic>> transactions = box.values
              .map((item) => Map<String, dynamic>.from(item as Map))
              .toList();

          return Column(
            children: [
              BalanceCard(
                totalBalance: totalBalance,
                totalIncome: totalIncome,
                totalExpenses: totalExpenses,
              ),
              Expanded(child: TransactionList(transactions: transactions)),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.purple, size: 35),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.history, color: Colors.purple, size: 35),
                onPressed: () {
                  List<Map<String, dynamic>> transactions = transactionsBox
                      .values
                      .map((item) => Map<String, dynamic>.from(item as Map))
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HistoryScreen(transactions: transactions),
                    ),
                  );
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.report, color: Colors.purple, size: 35),
                onPressed: () {
                  List<Map<String, dynamic>> transactions = transactionsBox
                      .values
                      .map((item) => Map<String, dynamic>.from(item as Map))
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReportScreen(transactions: transactions),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.purple, size: 35),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, size: 40, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
