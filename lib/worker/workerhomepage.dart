// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:major_project/book_worker/my_services.dart';
import 'package:major_project/models/service_model.dart';
import 'package:major_project/user/user_profile.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/activeWork.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';
import 'package:major_project/utils/viewPreviouswork.dart';
import 'package:provider/provider.dart';

import '../providers/service_provider.dart';

// String userImage = "";

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  late ServiceProvider serviceProvider;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    serviceProvider = Provider.of(context, listen: false);
    // pass name of worker in this section
    serviceProvider.fetchWorkerOrderData();
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
    serviceProvider = Provider.of(context);

    List<OrderModel> list = serviceProvider.getWorkerOrderList;
    int length = list.length;
    print(list);
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
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 320.00 * length,
                                  child: ListView.builder(
                                      itemCount: length,
                                      itemBuilder: (context, index) {
                                        OrderModel data = list[index];
                                        return ActiveWork(
                                            category: data.serviceCategory,
                                            services: [data.services],
                                            subcategory: data.serviceItem,
                                            username: data.userName,
                                            useraddress: data.userAddress,
                                            date: "",
                                            timeslot: data.time);
                                      }),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
