// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';

class ActiveWork extends StatefulWidget {
  String category, subcategory, username, useraddress, date, timeslot;

  List<String> services;

  ActiveWork(
      {super.key,
      required this.category,
      required this.services,
      required this.subcategory,
      required this.username,
      required this.useraddress,
      required this.date,
      required this.timeslot});

  @override
  State<ActiveWork> createState() => _ActiveWorkState();
}

class _ActiveWorkState extends State<ActiveWork> {
  bool accept = false;
  bool reject = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(
              color: Color.fromARGB(255, 222, 222, 222),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: (!reject)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyIconWidget(
                            message: widget.subcategory,
                            Backgroundcolor: Colors.yellow,
                            icon: ProblemIcons[widget.category]![
                                widget.subcategory],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.subcategory,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: widget.services.length,
                                    itemBuilder: (context, index) => Text(
                                          widget.services[index],
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.username,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.useraddress,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'TimeSlot',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.date,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '(${widget.timeslot})',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  (!accept)
                      ? Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    print('accepted');
                                    accept = true;
                                  });
                                },
                                //return false when click
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    print('rejected');
                                    reject = true;
                                  });
                                },
                                //return false when click
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Reject',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    print('view Details');
                                  });
                                },
                                //return false when click
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'View Details',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    print('Done');
                                  });
                                },
                                //return false when click
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Done',
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              )
            : Container(
                height: 100,
                child: Center(
                  child: Text(
                    'No Active Bookings',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ));
  }
}
