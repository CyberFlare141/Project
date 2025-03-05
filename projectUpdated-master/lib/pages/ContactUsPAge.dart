import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {
      "name": "Abdul Mumit Sazid",
      "email": "sazid.cse.20230104140@aust.edu",
      "image": "assets/images/contact1.png", // Replace with your image path
    },
    {
      "name": "Masrafi Iqbql",
      "email": "masrafi.cse.20230104140@aust.edu",
      "image": "assets/images/contact2.png", // Replace with your image path
    },
    {
      "name": "Samiul Islam",
      "email": "samiul.cse.20230104140@aust.edu",
      "image": "assets/images/contact3.png", // Replace with your image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: contacts.map((contact) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  // Image with Hero animation
                  Hero(
                    tag: contact["email"]!, // Unique tag for each contact
                    child: ClipOval(
                      child: Image.asset(
                        contact["image"]!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Name
                  Text(
                    contact["name"]!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Email
                  Text(
                    contact["email"]!,
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}