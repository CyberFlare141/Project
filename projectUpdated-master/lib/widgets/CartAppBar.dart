import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // Navigate back to the previous screen
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.blueGrey
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Cart",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                  color: Colors.blueAccent
              ),
            ),
          ),
          Spacer(),
          Icon(
            Icons.more_vert,
            size: 30,
            color: Colors.indigo
          ),
        ],
      ),
    );
  }
}