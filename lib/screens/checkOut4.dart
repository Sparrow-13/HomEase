// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/models/worker_model.dart';
import 'package:major_project/screens/singleProduct.dart';

import 'package:major_project/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../providers/worker_provider.dart';

class SelectWorker extends StatefulWidget {
  List<BookModel> services;
  String address;
  String date;
  String time;
  SelectWorker(
      {super.key,
      required this.services,
      required this.address,
      required this.date,
      required this.time});

  @override
  State<SelectWorker> createState() => _SelectWorkerState();
}

class _SelectWorkerState extends State<SelectWorker> {
  late WorkerProvider workerProvider;

  @override
  void initState() {
    //set the initial value of text field
    WorkerProvider workerProvider = Provider.of(context, listen: false);
    workerProvider.fetchCarpentersData();
    workerProvider.fetchPlumbersData();
    workerProvider.fetchElectriciansData();

    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    workerProvider = Provider.of(context);
    int length = 0;
    List<WorkerModel> dataList = [];
    if (widget.services[0].Category == "Carpenter") {
      length = workerProvider.getCarpenterWorkerList.length;
      dataList = workerProvider.getCarpenterWorkerList;
    } else if (widget.services[0].Category == "Electrician") {
      length = workerProvider.getElectricianWorkerList.length;
      dataList = workerProvider.getElectricianWorkerList;
    } else if (widget.services[0].Category == "Plumber") {
      length = workerProvider.getPlumberWorkerList.length;
      dataList = workerProvider.getPlumberWorkerList;
    }

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
                        endChild: Text(
                          'Cart',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                        endChild: Text(
                          'Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                            iconData: Icons.check_circle,
                          ),
                        ),
                        endChild: Text(
                          'TimeSlot',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        // lineXY: MediaQuery.of(context).size.width/4 -10,
                      ),
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        beforeLineStyle: LineStyle(color: Colors.green),
                        // lineXY: MediaQuery.of(context).size.width/4 -10,
                        indicatorStyle: IndicatorStyle(
                            color: Colors.green,
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.looks_4_rounded,
                            ),
                            height: 30),
                        endChild: Text(
                          'Worker',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Select A Worker",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              (length == 0)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        WorkerModel data = dataList[index];
                        //    WorkerModel data = workerProvider.getCarpenterWorkerList[index];
                        return SingleProduct(
                          name: data.workerName,
                          address: data.workerAddress,
                          age: data.workerAge,
                          category: data.workerCategory,
                          image: data.workerImage,
                          rating: data.workerRating,
                          services: widget.services,
                          time: widget.time,
                          userAddress: widget.address,
                        );
                      }),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         color: Colors.green,
              //         borderRadius: BorderRadius.circular(12)),
              //     child: TextButton(
              //       child: Text('Next',
              //           style: TextStyle(fontSize: 24, color: white)),
              //       onPressed: () => {},
              // ),
              //   ),
              // )
            ],
          ),
        ));
  }
}
