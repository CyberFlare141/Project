import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projects/pages/CartPage.dart';
import 'package:projects/pages/UploadItemPage.dart';
import 'package:projects/pages/ContactUsPAge.dart'; // Import ContactUsPage
import 'package:projects/pages/SideMenuPage.dart'; // Import SideMenuPage
import 'package:projects/pages/profile_page.dart'; // Import ProfileScreen
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open the side menu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SideMenuPage()),
              );
            },
          ),
        ],
      ),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Message
                    Text(
                      "Welcome, User!", // Replace with dynamic user email if needed
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
                    // Category Options
                    Wrap(
                      spacing: 10, // Horizontal spacing between category chips
                      runSpacing: 10, // Vertical spacing between category chips
                      children: [
                        _buildCategoryChip("Book"),
                        _buildCategoryChip("Electronics"),
                        _buildCategoryChip("Material"),
                        _buildCategoryChip("Sports"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // StreamBuilder to fetch and display items
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No items found.'));
                        }

                        final items = snapshot.data!.docs;

                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: items.map((DocumentSnapshot document) {
                            final item =
                            document.data() as Map<String, dynamic>;
                            return _buildCategoryCard(
                              Icons
                                  .shopping_bag, // You can change the icon based on category
                              item['name'],
                              item['price'],
                              item['imageUrl'],
                            );
                          }).toList(),
                        );
                      },
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
            // Navigate to upload item page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadItemPage()),
            );
          } else if (index == 2) {
            // Navigate to cart
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
  Widget _buildCategoryCard(
      IconData icon, String title, String price, String imageUrl) {
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
            Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
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

  // Helper method to build category chips
  Widget _buildCategoryChip(String category) {
    return Chip(
      label: Text(category),
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    );
  }
}