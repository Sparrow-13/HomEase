// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/categories.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';

class PreviousWorkCard extends StatefulWidget {
  String category, subcategory, username, rating, useraddress, date, timeslot;
  

  List<String> services;

  PreviousWorkCard(
      {super.key,
      required this.category,
      required this.services,
      required this.subcategory,
      required this.username,
      required this.useraddress,
      required this.rating,
      required this.date,
      required this.timeslot});

  @override
  State<PreviousWorkCard> createState() => _PreviousWorkCardState();
}

class _PreviousWorkCardState extends State<PreviousWorkCard> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color:  white,
            border: Border.all(
              color: Color.fromARGB(255, 222, 222, 222),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
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
                      icon: ProblemIcons[widget.category]![widget.subcategory],
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
                Column(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            widget.rating,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 16),
                          )
                        ],
                      )
                    
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
            
               
          ],
        ));
  }
}
