// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:major_project/book_worker/my_services.dart';
import 'package:major_project/user/user_profile.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/activeWork.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';
import 'package:major_project/utils/viewPreviouswork.dart';

// String userImage = "";

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
            key: _key,
            // drawer: MyDrawer(user, context),
            body: SafeArea(
                // width: double.infinity,
                // height: double.infinity,
                // color: Color.fromARGB(255, 245, 245, 245),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _key.currentState?.openDrawer(),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                    )),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28,
                                      child: IconButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyServices())),
                                        icon: Icon(Icons.shop_2,
                                            color: Colors.black),
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfile())),
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/homease-daea1.appspot.com/o/carpenters%2F1671718882655?alt=media&token=68083e3e-da35-4779-87d3-ab0a0b34f48d'),
                                      ))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "Hello Partner",
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "Harish",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Active Booking",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5,),
                                ActiveWork(
                                    category: 'Carpenter',
                                    subcategory: 'Bed',
                                    services: ['Leg Repair'],
                                    username: 'Tulsi Das',
                                    useraddress:
                                        '37, Gandhi colony, Bhawarkuan, Indore',
                                    date: '31/03/2023',
                                    timeslot: '05:00PM - 07:00PM',
                                    ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Previous Bookings",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                PreviousWorkCard(

                                    category: 'Carpenter',
                                    subcategory: 'Furniture Repair',
                                    services: ['Chairs'],
                                    username: 'Faizan Mansuri',
                                    useraddress:
                                        '15, Green Park colony , Chandan Nagar, Indore',
                                    date: '29/03/2023',
                                    timeslot: '03:00PM - 05:00PM',
                                    rating: '4.0'),
                                PreviousWorkCard(

                                    category: 'Carpenter',
                                    subcategory: 'Door',
                                    services: [
                                      'Hinges',
                                      'Door Installation',
                                      'Repair'
                                    ],
                                    username: 'Rahul Gupta',
                                    useraddress:
                                        '15, Guru nanak colony , precanco colony, Indore',
                                    date: '27/03/2023',
                                    timeslot: '11:00AM - 01:00PM',
                                    rating: '5.0'),
                                PreviousWorkCard(
                                    
                                    category: 'Carpenter',
                                    subcategory: 'Bed',
                                    services: ['Leg Repair', 'Support Repair'],
                                    username: 'Asif Sheikh',
                                    useraddress: '15, karol bagh colony , Chandan Nagar, Indore',
                                    date: '27/03/2023',
                                    timeslot: '09:00AM - 11:00AM',
                                    rating: '3.0'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
