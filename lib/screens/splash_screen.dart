import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Hive.initFlutter();

    var settingsBox = await Hive.openBox('settings');
    var transactionsBox =
        await Hive.openBox('transactions'); // ✅ Open transactions box here

    final isFirstLaunch = settingsBox.get('isFirstLaunch', defaultValue: true);

    if (isFirstLaunch) {
      await settingsBox.put('isFirstLaunch', false);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
                transactionsBox: transactionsBox), // ✅ Pass box to HomeScreen
          ),
        );
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
              transactionsBox: transactionsBox), // ✅ Pass box to HomeScreen
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Budget Buddy",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 84, 4, 159),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Keep track of your money.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.purple),
          ],
        ),
      ),
    );
  }
}
