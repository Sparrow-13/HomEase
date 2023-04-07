// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/screens/checkOut2.dart';
import 'package:major_project/utils/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Cart extends StatefulWidget {
  List<BookModel> services;
  Cart({
    super.key,
    required this.services,
  });

  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),
          color: Colors.black,
        ),
        elevation: 1,
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
                            indicatorStyle: IndicatorStyle(
                              color: Colors.green,
                              height: 30,
                              iconStyle: IconStyle(
                                  color: Colors.white,
                                  iconData: Icons.looks_one_rounded,
                              ),
                            ),
                            endChild: Text('Cart' , style: TextStyle( fontWeight: FontWeight.bold),),
                            // lineXY: MediaQuery.of(context).size.width/4 -10,
                          ),
                          TimelineTile(
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.center,
                            indicatorStyle: IndicatorStyle(
                              height: 30),
                              endChild: Text('Address' , style: TextStyle( fontWeight: FontWeight.bold),),
                            ),
                            
                            // lineXY: MediaQuery.of(context).size.width/4 
                          TimelineTile(
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.center,
                            indicatorStyle: IndicatorStyle(
                              height: 30),
                              endChild: Text('TimeSlot' , style: TextStyle( fontWeight: FontWeight.bold),),
                            // lineXY: MediaQuery.of(context).size.width/4 -10,
                          ),
                          TimelineTile(
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.center,
                            // lineXY: MediaQuery.of(context).size.width/4 -10,
                            indicatorStyle: IndicatorStyle(
                              height: 30),
                            isLast: true,
                            endChild: Text('Worker' , style: TextStyle( fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: widget.services.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(widget.services[index].serviceItem),
                        subtitle: Text(widget.services[index].requestedservice),
                        leading: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                                'images/${widget.services[index].serviceItem}.png')),
                        trailing: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              print('removing');
                              widget.services.removeWhere((BookModel) =>
                                  BookModel.requestedservice ==
                                  widget.services[index].requestedservice);
                            });
                          },

                          //return false when click
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.red, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Remove',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
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
                        onPressed: () => {Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartAddress(
                                  services: widget.services,
                                )))},
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
