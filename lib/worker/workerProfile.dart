// ignore_for_file: file_names, avoid_unnecessary_containers   , prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/models/worker_model.dart';
import 'package:major_project/providers/service_provider.dart';
import 'package:major_project/screens/homepage_2.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class WorkerProfile extends StatefulWidget {
  final String name;
  final String address;
  final String category;
  final int rating;
  final int age;
  final String image;
  const WorkerProfile(
      {super.key,
      required this.name,
      required this.address,
      required this.category,
      required this.rating,
      required this.age,
      required this.image});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  TextEditingController problemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorkerModel workerModel = WorkerModel(widget.name, widget.image, widget.age,
        widget.rating, widget.address, widget.category);

    ServiceProvider serviceProvider = Provider.of(context);

    bookWorker() async {
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference ref = FirebaseFirestore.instance
          .collection("userServices")
          .doc(user?.uid)
          .collection("YourServices");
      bool isAlreadyBooked = false;
      QuerySnapshot snapshot = await ref.get();
      for (var element in snapshot.docs) {
        if (element.id == workerModel.workerName) {
          isAlreadyBooked = true;
        }
      }
      if (isAlreadyBooked) {
        SnackBar snackBar = SnackBar(
          content: Text('You have already requested this worker'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (snapshot.docs.length > 2) {
        SnackBar snackBar = SnackBar(
          content: Text(
              'You have crossed the limit of requests you can place in a day'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        try {
          serviceProvider.addServiceData(
            workerModel: workerModel,
            date: DateTime.now(),
            user: FirebaseAuth.instance.currentUser,
            problemDesc: problemController.text,
          );
          SnackBar snackBar = SnackBar(
            content: Text('Your service request is successfully placed'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
        } catch (err) {
          SnackBar snackBar = SnackBar(
            content: Text('$err'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage2(0)));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          InkWell(
            splashColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(MdiIcons.bookmarkOutline),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(children: [
            SingleChildScrollView(
              // child: Container(
              //   // color: offwhite,
              //   width: double.infinity,
              //   color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.address,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Icon(
                          MdiIcons.circleSmall,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          '${widget.rating}⭐',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Icon(
                          MdiIcons.circleSmall,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          '${widget.age} years',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MyIconWidget(
                          message: 'Location',
                          Backgroundcolor: lightgreen,
                          icon: Icons.location_on,
                          Iconsize: 28,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  widget.address,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        MyIconWidget(
                          message: '',
                          Backgroundcolor: lightblue,
                          icon: CategoriesIcons[widget.category],
                          Iconsize: 28,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Service type',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  widget.category,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Services',
                      style: TextStyle(fontWeight: FontWeight.w800),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: [
                        for (int i = 0;
                            i < ProblemIcons[widget.category]!.length;
                            i++)
                          MyIconWidget(
                            message: '${categoryOffers[widget.category][i]}',
                            Backgroundcolor: CustomColors[i % 5],
                            icon: ProblemIcons[widget.category]![
                                categoryOffers[widget.category]![i]]!,
                            Iconsize: 28,
                          ),
                      ],
                    )
                  ],
                ),
              ),
              // ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  child: Text('Book Now',
                      style: TextStyle(fontSize: 24, color: offwhite)),
                  onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Enter problem Description'),
                              content: Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: problemController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            print("sending.......");
                                            bookWorker();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text("Confirm Book")),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ),
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
