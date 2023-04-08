// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:major_project/user/user_login.dart';
import 'package:major_project/utils/colors.dart';
import 'package:major_project/screens/homepage_2.dart';
import 'package:major_project/worker/workerhomepage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/CustomIcons.dart';

class RegisterSelectorPage extends StatefulWidget {
  const RegisterSelectorPage({super.key});

  @override
  State<RegisterSelectorPage> createState() => RegisterSelectorPageState();
}

class RegisterSelectorPageState extends State<RegisterSelectorPage> {
  int accounttype = 0;

  void nextWindow() {
    if (accounttype == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    }
    
    else if (accounttype == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorkerHomePage()));
    }
    else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Select Type"),
                duration: Duration(milliseconds: 300),
              ));
    }
  }

  Widget CustomRadioButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          accounttype = index;
          print(accounttype);
        });
      },
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
            color: (accounttype == index) ? Colors.grey : lightred,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyIconWidget(
                message: '',
                Backgroundcolor: white,
                icon: (index == 1)
                    ? MdiIcons.accountHardHat
                    : Icons.account_circle),
            SizedBox(
              height: 10,
            ),
            Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          // title: Text(
          //   "Select role",
          //   style: TextStyle(color: Colors.black),
          // ),
          // centerTitle: true,
          backgroundColor: white,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Text(
                  "Select Your Role",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomRadioButton('User', 0),
                  CustomRadioButton('Worker', 1),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                      child: Text('Next',
                          style: TextStyle(fontSize: 24, color: offwhite)),
                      onPressed: () => nextWindow()),
                ),
              )
            ],
          ),
        ));
  }
}
