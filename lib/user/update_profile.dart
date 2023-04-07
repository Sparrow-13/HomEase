// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/models/user_model.dart';
import 'package:major_project/user/constants.dart';
import 'package:major_project/user/user_profile.dart';
import 'package:major_project/utils/colors.dart';

final nameController = TextEditingController(text: userModel?.userName);
final phoneController = TextEditingController(text: userModel?.userPhone);
final addressController = TextEditingController(text: userModel?.userAddress);

final _formKey = GlobalKey<FormState>();
Future update(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  try {
    FirebaseFirestore.instance.collection("User").doc(user?.uid).set({
      "userName": nameController.text,
      "userAddress": addressController.text,
      "userPhone": phoneController.text,
      "userId": user?.uid,
    });
    user?.updateDisplayName(nameController.text);
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    // Navigator.pushAndRemoveUntil(context);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserProfile()));
  } catch (e) {
    print(e);
  }
}

class UpdateProfile extends StatefulWidget {
  UserModel? userModel;
  UpdateProfile({super.key, this.userModel});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = userModel!.userName;
    phoneController.text = userModel!.userPhone;
    addressController.text = userModel!.userAddress;
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Action"),
                  content: Text("Are you sure you want to unsave the changes?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      //return true when click on "Yes"
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Don\'t Save'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.done_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    update(context);
                  } else {
                    print("Upload Failed");
                  }
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: white,
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          UploadImageToFirebase();
                        });
                      },
                      child: CircleAvatar(
                        radius: 78,
                        backgroundColor: white,
                        child: user?.photoURL != null
                            ? Stack(children: [
                                CircleAvatar(
                                  radius: 72,
                                  backgroundColor: Colors.grey.shade800,
                                  backgroundImage:
                                      NetworkImage((user?.photoURL).toString()),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: lightblue,
                                      radius: 25,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                      ),
                                    ))
                              ])
                            : CircleAvatar(
                                radius: 72,
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: kTextFormFieldStyle(),
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                          onPressed: nameController.clear,
                        ),
                        labelStyle: TextStyle(color: Colors.red),
                        floatingLabelStyle: TextStyle(color: Colors.red),

                        // hintStyle: TextStyle(
                        //   color: Colors.green
                        // ),
                        focusColor: Colors.red,

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.red)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        hintText: 'Enter Your Name',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      controller: nameController,

                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: phoneController,
                      style: kTextFormFieldStyle(),

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.blue,
                          ),
                          onPressed: phoneController.clear,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        hintText: 'Enter Your Phone No.',
                        labelText: 'Phone No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone no.';
                        } else if (value.length != 10) {
                          return 'Enter correct number';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      cursorColor: Colors.green,
                      style: kTextFormFieldStyle(),

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.green,
                          ),
                          onPressed: addressController.clear,
                        ),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.green,
                        ),

                        hintText: 'Enter Your Address',
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Colors.green),

                        // hintStyle: TextStyle(
                        //   color: Colors.green
                        // ),
                        focusColor: Colors.green,

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.green)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      controller: addressController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightblue,
                        //MaterialStateProperty.all(Colors.deepPurpleAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          update(context);
                        } else {
                          print("Upload Failed");
                        }
                      },
                      child: const Text('Save Details',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
