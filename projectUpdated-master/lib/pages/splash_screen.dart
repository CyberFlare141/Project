import 'package:flutter/material.dart';
import 'package:projects/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // Start fully visible

  @override
  void initState() {
    super.initState();

    // Gradually fade the logo after a short delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.0; // Fade out
      });

      // Navigate to Home Page after the fade-out animation
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2), // Adjust for smoother transition
          child: Image.asset(
            'assets/image/logo.png', // Make sure this asset exists
            width: 1000, // Adjust size as needed
          ),
        ),
      ),
    );
  }
}





