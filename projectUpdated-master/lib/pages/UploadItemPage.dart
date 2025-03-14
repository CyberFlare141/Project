import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class UploadItemPage extends StatefulWidget {
  @override
  _UploadItemPageState createState() => _UploadItemPageState();
}

class _UploadItemPageState extends State<UploadItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final picker = ImagePicker();
  String? _selectedCategory;
  bool _isUploading = false;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();

  final List<String> _categories = ['Book', 'Electronics', 'Material', 'Sports'];

  /// Pick an image while preserving form values
  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageNotifier.value = File(pickedFile.path);
        FocusScope.of(context).requestFocus(_nameFocus);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  /// Upload item details to Firebase
  Future<void> _uploadItem() async {
    if (!_formKey.currentState!.validate()) {
      print("Form validation failed.");
      return;
    }

    if (_imageNotifier.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a category.')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to upload an item.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('item_images/${DateTime.now().toIso8601String()}');
      await storageRef.putFile(_imageNotifier.value!);
      final imageUrl = await storageRef.getDownloadURL();

      // Upload item details to Firestore
      await FirebaseFirestore.instance.collection('items').add({
        'name': _itemNameController.text,
        'description': _itemDescriptionController.text,
        'price': double.parse(_itemPriceController.text),
        'imageUrl': imageUrl,
        'category': _selectedCategory,
        'sellerId': user.uid,
        'timestamp': Timestamp.now(),
      });

      // Reset form
      _itemNameController.clear();
      _itemDescriptionController.clear();
      _itemPriceController.clear();
      _imageNotifier.value = null;
      _selectedCategory = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item uploaded successfully!')),
      );
    } catch (e) {
      print("Error uploading item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload item. Please try again.')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemDescriptionController.dispose();
    _itemPriceController.dispose();
    _nameFocus.dispose();
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Item",
          style: TextStyle(color: Colors.white), // Change text color here
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.white),
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Name
                TextFormField(
                  controller: _itemNameController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.shopping_bag, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter the item name' : null,
                ),
                SizedBox(height: 30),

                // Item Description
                TextFormField(
                  controller: _itemDescriptionController,
                  focusNode: _descriptionFocus,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.description, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 3,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a description' : null,
                ),
                SizedBox(height: 20),

                // Item Price
                TextFormField(
                  controller: _itemPriceController,
                  focusNode: _priceFocus,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter the price';
                    if (double.tryParse(value) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: Text('Select Category', style: TextStyle(color: Colors.white)),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category, style: TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.category, color: Colors.white),
                  ),
                  dropdownColor: Colors.blue.shade300,
                  validator: (value) => value == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 20),

                // Image Preview
                ValueListenableBuilder<File?>(
                  valueListenable: _imageNotifier,
                  builder: (context, image, child) {
                    return image == null
                        ? Text('No image selected.', style: TextStyle(color: Colors.white))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(image, height: 200),
                    );
                  },
                ),
                SizedBox(height: 30),

                // Pick Image Button
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image, color: Colors.white),
                  label: Text('Pick Image', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                ),
                SizedBox(height: 30),

                // Upload Button
                _isUploading
                    ? Center(child: CircularProgressIndicator(color: Colors.white))
                    : ElevatedButton.icon(
                  onPressed: _uploadItem,
                  icon: Icon(Icons.upload, color: Colors.white),
                  label: Text('Upload Item', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}