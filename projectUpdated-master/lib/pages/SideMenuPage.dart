import 'package:flutter/material.dart';
import 'ContactUsPAge.dart'; // Import the ContactUsPage

class SideMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, // Cover half the screen width
      height: MediaQuery.of(context).size.height, // Full height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade900, Colors.blue.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Back button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Close the side menu
                },
              ),
            ),
          ),
          Spacer(), // Push buttons to the center
          ElevatedButton(
            onPressed: () {
              // Navigate to Contact Us page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger and bold text
            ),
            child: Text("Contact Us"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle Get Help action
              Navigator.pop(context); // Close the side menu
              // Add your get help logic here
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Larger and bold text
            ),
            child: Text("Get Help"),
          ),
          Spacer(), // Push buttons to the center
        ],
      ),
    );
  }
}