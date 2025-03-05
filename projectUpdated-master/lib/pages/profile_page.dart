import 'package:flutter/material.dart';
import '../auth.dart';
import 'home_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _opacity = 0.0;
  final TextEditingController _prevPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

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
    Navigator.of(context).pop(); // Navigate back to the home page after signing out
  }

  void _changePassword() async {
    // Show dialog to change password
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _prevPasswordController,
                decoration: InputDecoration(hintText: "Previous Password"),
                obscureText: true,
              ),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(hintText: "New Password"),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Check if the previous password is correct
                try {
                  await Auth().signInWithEmailAndPassword(
                    email: Auth().currentUser !.email!,
                    password: _prevPasswordController.text,
                  );
                  // If successful, update the password
                  await Auth().currentUser !.updatePassword(_newPasswordController.text);
                  Navigator.of(context).pop(); // Close the dialog
                  _prevPasswordController.clear();
                  _newPasswordController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password changed successfully!")));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to change password: ${e.toString()}")));
                }
              },
              child: Text("Change"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50), // Space from the top
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), // Larger and bold text
                ),
              ),
              SizedBox(height: 25),
              // Display email only
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: Text(
                  "Email: ${Auth().currentUser ?.email ?? 'Not logged in'}",
                  style: TextStyle(fontSize: 25, color: Colors.white), // Increased text size
                ),
              ),
              SizedBox(height: 25),
              // Change Password Button
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger and bold text
                  ),
                  child: Text("Change Password"),
                ),
              ),
              SizedBox(height: 25),
              // Back to Home Button
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger and bold text
                  ),
                  child: Text("Go to Home"),
                ),
              ),
              SizedBox(height: 25),
              // Sign Out Button
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: signOut,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger and bold text
                  ),
                  child: Text("Sign Out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}