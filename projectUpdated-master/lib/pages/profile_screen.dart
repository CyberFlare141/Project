import 'package:flutter/material.dart';
import 'package:projects/auth.dart';
import 'package:projects/pages/login_register_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Delay the appearance of the text
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; // Change opacity to 1 after 1 second
      });
    });
  }

  Future<void> signOut() async {
    await Auth().signOut();

    // Navigate to Login Page after signing out
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false, // Remove all previous screens
    );
  }

  Future<void> goBack() async {
    await Future.delayed(Duration(milliseconds: 200)); // 200 ms delay
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: goBack, // Use the goBack method with delay
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'profileHero',
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: Text(
                "Your Profile",
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: signOut,
                child: Text("Sign Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
