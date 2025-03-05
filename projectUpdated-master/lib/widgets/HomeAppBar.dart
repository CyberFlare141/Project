import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:projects/pages/profile_page.dart'; // Import the ProfileScreen

class HomeAppBar extends StatelessWidget {
  final Function(String?)? onCategorySelected; // Callback for category selection

  const HomeAppBar({Key? key, this.onCategorySelected}) : super(key: key); // Add this parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Icon(
            Icons.sort,
            size: 30,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Campus Bazaar",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
          // Add the category filter dropdown
          DropdownButton<String>(
            value: null, // No default selection
            hint: Text(
              'Filter by Category',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            items: ['Book', 'Electronics', 'Material', 'Sports'].map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(
                  category,
                  style: TextStyle(
                    color: Colors.black, // Dropdown text color
                  ),
                ),
              );
            }).toList(),
            onChanged: onCategorySelected, // Use the callback
            dropdownColor: Colors.white, // Dropdown background color
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white, // Dropdown icon color
            ),
            isExpanded: false, // Do not expand the dropdown
            underline: Container(), // Remove the default underline
          ),
          SizedBox(width: 20), // Add some spacing
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: Hero(
              tag: 'profileHero', // Unique tag for the hero animation
              child: badges.Badge(
                badgeContent: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 35,
                  color: Colors.blueGrey,
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.redAccent,
                  padding: EdgeInsets.all(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}