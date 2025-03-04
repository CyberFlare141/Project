import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/auth.dart';
import 'package:projects/widgets/HomeAppBar.dart';
import 'package:projects/pages/CartPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    try {
      await Auth().signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeAppBar(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Message
                    Text(
                      "Welcome, ${user?.email ?? 'User'}!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search here...",
                                hintStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Add search functionality
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Featured Section
                    const Text(
                      "Featured: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFeaturedCard(
                            "https://via.placeholder.com/150",
                            "Product 1",
                            "\৳120",
                          ),
                          _buildFeaturedCard(
                            "https://via.placeholder.com/150",
                            "Product 2",
                            "\৳200",
                          ),
                          _buildFeaturedCard(
                            "https://via.placeholder.com/150",
                            "Product 3",
                            "\৳250",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Categories Section
                    const Text(
                      "Categories: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildCategoryCard(Icons.book, "Book"),
                        _buildCategoryCard(Icons.phone_android, "Electronics"),
                        _buildCategoryCard(Icons.class_, "Metarials"),
                        _buildCategoryCard(Icons.sports_football, "Sports"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {
          // Handle navigation based on the index
          if (index == 0) {
            // Navigate to home
          } else if (index == 1) {
            // Navigate to cart
          } else if (index == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          }
        },
        height: 70,
        color: Colors.black,
        items: const [
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.add_circle_outline,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // Helper method to build featured cards
  Widget _buildFeaturedCard(String imageUrl, String title, String price) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build category cards
  Widget _buildCategoryCard(IconData icon, String title) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}