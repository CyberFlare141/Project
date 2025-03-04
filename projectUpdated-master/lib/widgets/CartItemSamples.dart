import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemSamples extends StatefulWidget {
  @override
  _CartItemSamplesState createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // List of cart items
  final List<Map<String, String>> cartItems = [
    {
      "image": "assets/images/item1.png",
      "title": "Product Title 1",
      "price": "৳120"
    },
    {
      "image": "assets/images/item2.png",
      "title": "Product Title 2",
      "price": "৳150"
    },
    {
      "image": "assets/images/item3.png",
      "title": "Product Title 3",
      "price": "৳200"
    },
    {
      "image": "assets/images/item4.png",
      "title": "Product Title 4",
      "price": "৳250"
    },
  ];

  // Function to delete an item
  void _deleteItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < cartItems.length; i++)
          _buildCartItem(
            cartItems[i]["image"]!,
            cartItems[i]["title"]!,
            cartItems[i]["price"]!,
            i,
          ),
      ],
    );
  }

  Widget _buildCartItem(String imagePath, String title, String price, int index) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Radio(
            value: "",
            groupValue: "",
            onChanged: (index) {},
          ),
          Container(
            height: 70,
            width: 70,
            margin: EdgeInsets.only(right: 15),
            child: Image.asset(imagePath),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                Text(
                  price,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _deleteItem(index); // Call the delete function
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}