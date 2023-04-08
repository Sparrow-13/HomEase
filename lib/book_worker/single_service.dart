
// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:major_project/models/worker_model.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';

class SingleService extends StatelessWidget {
  final DateTime date;
  final WorkerModel workerModel;
  final String problemDesc;
  SingleService(
      {super.key,
      required this.date,
      required this.workerModel,
      required this.problemDesc});
      // Widget service_card = Container(
      //   margin: EdgeInsets.only(bottom: 10),
      //   padding: EdgeInsets.all(20),
      //   decoration: BoxDecoration(
      //       color:  white,
      //       border: Border.all(
      //         color: Color.fromARGB(255, 222, 222, 222),
      //       ),
      //       borderRadius: BorderRadius.all(Radius.circular(20))),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               MyIconWidget(
      //                 message: 'Subcategory',
      //                 Backgroundcolor: Colors.yellow,
      //                 icon: ProblemIcons['Carpenter']!['Furniture Repair'],
      //               ),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     widget.subcategory,
      //                     style: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 18,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                   SizedBox(
      //                     width: 200,
      //                     child: ListView.builder(
      //                         shrinkWrap: true,
      //                         physics: ClampingScrollPhysics(),
      //                         itemCount: widget.services.length,
      //                         itemBuilder: (context, index) => Text(
      //                               widget.services[index],
      //                               style: TextStyle(
      //                                   color: Colors.black45,
      //                                   fontSize: 16,
      //                                   fontWeight: FontWeight.bold),
      //                             )),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Column(
      //                   children: [
      //                     Icon(
      //                       Icons.star_rounded,
      //                       color: Colors.amber,
      //                     ),
      //                     Text(
      //                       widget.rating,
      //                       style:
      //                           TextStyle(color: Colors.black38, fontSize: 16),
      //                     )
      //                   ],
      //                 )
                    
      //         ],
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Text(
      //         workerModel.workerName,
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(
      //         height: 5,
      //       ),
      //       Text(
      //         widget.useraddress,
      //         style: TextStyle(
      //             color: Colors.black45,
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Text(
      //         'TimeSlot',
      //         style: TextStyle(
      //             color: Colors.black45,
      //             fontSize: 14,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(
      //         height: 5,
      //       ),
      //       Row(
      //         children: [
      //           Text(
      //             widget.date,
      //             style: TextStyle(
      //                 color: Colors.black,
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           Text(
      //             '(${widget.timeslot})',
      //             style: TextStyle(
      //                 color: Colors.black45,
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //         ],
      //       ),
            
               
      //     ],
      //   ));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: lightblue, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(workerModel.workerImage),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date of Request:\n ${date}",
                style: textstyle(),
              ),
              Text("Name:${workerModel.workerName}", style: textstyle()),
              Text("Address:${workerModel.workerAddress}", style: textstyle()),
              Text(
                "Your Problem: \n $problemDesc",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

TextStyle textstyle() => const TextStyle(
      color: Colors.black,
      fontSize: 17,
    );


