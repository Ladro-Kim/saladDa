import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salad_da/models/item.dart';
import 'package:salad_da/provs/provider_firebase.dart';
import 'package:salad_da/utils/photo_handler.dart';
import 'package:salad_da/widgets/widget_select_photo.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage>
    with TickerProviderStateMixin {
  GlobalKey<FormState> _itemFormKey = GlobalKey<FormState>();
  bool isImageSelected = false;
  File selectedPhoto;

  TextEditingController _itemNameController;
  TextEditingController _itemPriceController;
  TextEditingController _itemCaloriesController;
  TextEditingController _itemInformationController;

  bool isUploading = false;

  @override
  void initState() {
    _itemFormKey = GlobalKey<FormState>();
    _itemNameController = TextEditingController();
    _itemPriceController = TextEditingController();
    _itemCaloriesController = TextEditingController();
    _itemInformationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemCaloriesController.dispose();
    _itemInformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add Item"),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _itemFormKey,
                  child: Column(
                    children: [
                      itemPhoto(),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _itemNameController,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _itemPriceController,
                        decoration: InputDecoration(
                          labelText: "Price",
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _itemCaloriesController,
                        decoration: InputDecoration(
                          labelText: "Calories",
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _itemInformationController,
                        decoration: InputDecoration(
                          labelText: "Information",
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              addButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget itemPhoto() {
    return InkWell(
      child: selectedPhoto == null
          ? SelectPhotoWidget()
          : Image.file(selectedPhoto),
      onTap: () async {
        selectedPhoto = await getPhotoFromGallery();
        setState(() {});
      },
    );
  }

  InkWell addButton(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.lightGreenAccent,
        child: Center(
            child: isUploading
                ? CircularProgressIndicator()
                : Text("Add", style: TextStyle(fontWeight: FontWeight.bold))),
      ),
      onTap: () async {
        isUploading = true;
        setState(() {});
        await Provider.of<FirebaseProvider>(context, listen: false).setItem(
            Item(
              name: _itemNameController.text,
              price: double.parse(_itemPriceController.text.trim()),
              calorie: double.parse(_itemCaloriesController.text.trim()),
              information: _itemInformationController.text,
              editor: FirebaseAuth.instance.currentUser.email,
              uploadDate: DateTime.now(),
            ),
            selectedPhoto);
        Navigator.pop(context);
      },
    );
  }
}

// int code;
// String name;
// double price;
// String imageUri;
// String information;
// double calorie;
