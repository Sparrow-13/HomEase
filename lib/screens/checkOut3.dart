// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/screens/checkOut4.dart';

import 'package:major_project/utils/colors.dart';
import 'package:major_project/utils/timeslot.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeSlot extends StatefulWidget {
  List<BookModel> services;
  String address;

  TimeSlot({super.key, required this.services, required this.address});

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  TextEditingController dateInput = TextEditingController();
  int time_slot = 0;
  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  Widget CustomRadioButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          time_slot = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: (time_slot == index) ? Colors.green : Colors.black)),
        width: MediaQuery.of(context).size.width / 2.35,
        padding: EdgeInsets.all(15),
        child: Text(
          text,
          style: TextStyle(
            color: (time_slot == index) ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Time Slot',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(true),
            color: Colors.black,
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        isFirst: true,
                        afterLineStyle: LineStyle(color: Colors.green),

                        indicatorStyle: IndicatorStyle(
                          color: Colors.green,
                          // padding: EdgeInsets.all(8),

                          height: 30,

                          iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.check_circle,
                          ),
                        ),
                        endChild: Text('Cart' , style: TextStyle( fontWeight: FontWeight.bold),),
                        // lineXY: MediaQuery.of(context).size.width/4 -10,
                      ),
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        beforeLineStyle: LineStyle(color: Colors.green),
                        indicatorStyle: IndicatorStyle(
                            color: Colors.green,
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.check_circle,
                            ),
                            height: 30),
                            endChild: Text('Address' , style: TextStyle( fontWeight: FontWeight.bold),),
                      ),

                      // lineXY: MediaQuery.of(context).size.width/4
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        beforeLineStyle: LineStyle(color: Colors.green),
                        indicatorStyle: IndicatorStyle(
                          height: 30,
                          color: Colors.green,
                          iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.looks_3_rounded,
                          ),
                        ),
                        endChild: Text('TimeSlot' , style: TextStyle( fontWeight: FontWeight.bold),),

                        // lineXY: MediaQuery.of(context).size.width/4 -10,
                      ),
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        // lineXY: MediaQuery.of(context).size.width/4 -10,
                        indicatorStyle: IndicatorStyle(height: 30),
                        endChild: Text('Worker' , style: TextStyle( fontWeight: FontWeight.bold),),
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Select Date and Timeslot",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: EdgeInsets.all(25),
                  height: MediaQuery.of(context).size.width / 3,
                  child: Center(
                      child: TextField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date",
                    ),

                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2024));

                      if (pickedDate != null) {
                        //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ))),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < timeslots.length;i++)
                    CustomRadioButton(timeslots[i], i),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    child: Text('Next',
                        style: TextStyle(fontSize: 24, color: white)),
                    onPressed: () => {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectWorker(
                                  services: widget.services,
                                  address: widget.address,
                                  date: dateInput.text,
                                  time: timeslots[time_slot],
                                  
                                )))
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
