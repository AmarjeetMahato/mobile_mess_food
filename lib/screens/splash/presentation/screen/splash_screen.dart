import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Timer to wait for 2-3 seconds before redirecting
    Timer(const Duration(seconds: 2), () {
      // Use pushReplacementNamed so the user can't "Go Back" to Splash
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // You can put your Mess App logo here
              const Icon(Icons.fastfood, size: 80, color: Color(0xFFFF6B35)),
              const SizedBox(height: 20),
              Text(
                "MESS FOOD",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0, // Using that stretch we talked about!
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
