// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:major_project/book_worker/single_service.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/models/user_model.dart';
import 'package:major_project/providers/user_provider.dart';
import 'package:major_project/screens/checkOut3.dart';
import 'package:major_project/user/update_profile.dart';
import 'package:major_project/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CartAddress extends StatefulWidget {
  List<BookModel> services;
  CartAddress({super.key, required this.services});

  @override
  State<CartAddress> createState() => _CartAddressState();
}

class _CartAddressState extends State<CartAddress> {
  String address = '25 , green park colony , chandan nagar , indore';
  int _selectedAddress = 1;
  TextEditingController _Addresscontroller = TextEditingController();

  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Select Address',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: (widget.services.isNotEmpty)
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
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
                                  iconData: Icons.looks_two_rounded,
                                ),
                                
                                height: 30),
                                endChild: Text('Address' , style: TextStyle( fontWeight: FontWeight.bold),),
                          ),

                          // lineXY: MediaQuery.of(context).size.width/4
                          TimelineTile(
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.center,
                            indicatorStyle: IndicatorStyle(height: 30),
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
                    "Select Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as int;
                              address =
                                  '25 , green park colony , chandan nagar , indore';
                            });
                          },
                        ),
                        Expanded(
                            child: Text(
                          '25 , green park colony , chandan nagar , indore',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.5),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as int;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _Addresscontroller,
                            decoration: InputDecoration(
                              hintText: 'Enter Different Address',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        child: Text('Next',
                            style: TextStyle(fontSize: 24, color: white)),
                        onPressed: () => {
                          if (_selectedAddress == 1)
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimeSlot(address: address, services: widget.services,)))
                            }
                          else
                            { Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimeSlot(address:addressController.text ,  services: widget.services,)))}
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: offwhite,
                    child: Image.asset('images/emptycart.png'),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  Text(
                    "Your Cart is Empty",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  )
                ],
              ),
            ),
    );
  }
}
