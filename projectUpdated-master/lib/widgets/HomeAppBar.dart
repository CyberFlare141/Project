import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:projects/pages/profile_page.dart'; // Import the ProfileScreen

class HomeAppBar extends StatelessWidget {
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