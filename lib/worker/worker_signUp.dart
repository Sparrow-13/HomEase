// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project/main.dart';
import 'package:major_project/user/constants.dart';
import 'package:major_project/user/update_profile.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';
import 'package:major_project/worker/workerLogin.dart';
import 'package:major_project/worker/workerhomepage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WorkerSignUpView extends StatefulWidget {
  const WorkerSignUpView({Key? key}) : super(key: key);

  @override
  State<WorkerSignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<WorkerSignUpView> {
  TextEditingController ageController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedItem = categories[0];
  Future SignUp() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      // User? user = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance
          .collection("Worker")
          .doc(emailController.text)
          .set({
        "workerName": nameController.text,
        "workerAddress": addressController.text,
        "workerPhone": phoneController.text,
        "workerEmail": emailController.text,
        "workerCategory": selectedItem,
        "workerAge": ageController.text,
        "workerPassword": passwordController.text,
        "workerImage": "",
        "workerRating": 3,
      });
      String name = nameController.text;

      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (ctx) => WorkerHomePage(workerName: name)));
    } on FirebaseException catch (e) {
      print(e);
      FocusManager.instance.primaryFocus?.unfocus();
      String err = e.toString();
      SnackBar snackBar = SnackBar(
        content: Text(err),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, theme);
              } else {
                return _buildSmallScreen(size, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(Size size, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(quarterTurns: 3, child: Text("")),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(Size size, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(Size size, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: size.width > 600
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbt8O9agjgkIDcPpF2AkAA5EJY2Vsf7WZxFY3sLaodBpSUHmJXrE8g2bxI8tpn6Uudj7M&usqp=CAU"))),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Sign Up',
                style: kLoginTitleStyle(size),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Create Account',
                style: kLoginSubtitleStyle(size),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      controller: nameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                        hintText: 'age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      controller: ageController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: 'Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      controller: addressController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Address';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.toolbox,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<String>(
                            value: selectedItem,
                            hint: Text('Select Service type'),
                            onChanged: (String? newValue) {
                              // update the selected item
                              setState(() {
                                selectedItem = newValue!;
                              });
                            },
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Gmail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),

                      controller: emailController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter gmail';
                        } else if (!value.endsWith('@gmail.com')) {
                          return 'please enter valid gmail';
                        }

                        return null;
                      },
                    ),

                    /// username

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// Gmail
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 7) {
                          return 'Password length should be atleast 7 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// Gmail
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.confirmation_number),
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        } else if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// password

                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                      style: kLoginTermsAndPrivacyStyle(size),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// SignUp Button
                    signUpButton(theme),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Navigate To Login Screen
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (ctx) => const WorkerLogin()));
                        confirmPasswordController.clear();
                        emailController.clear();
                        passwordController.clear();
                        _formKey.currentState?.reset();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: kHaveAnAccountStyle(size),
                          children: [
                            TextSpan(
                                text: " Login",
                                style: kLoginOrSignUpTextStyle(size)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(lightred),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
            SignUp();
          }
        },
        child: const Text('Sign up',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}
