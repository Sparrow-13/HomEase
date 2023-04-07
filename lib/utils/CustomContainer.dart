// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:major_project/screens/specificCategory.dart';
import 'package:major_project/screens/worker_list.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';

class CustomContainer extends StatefulWidget {
  var index;
  int counter;
  double height;
  double width;
  IconData icon;
  CustomContainer(this.index, this.counter, this.height, this.width ,this.icon);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => 
              SpecificCategoryWidget(widget.index)
              // WorkerList(category: widget.index)
              ),
        );
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: CustomColors[widget.counter % 5],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyIconWidget(
                message: '', Backgroundcolor: white, icon: widget.icon),
            SizedBox(
              height: 10,
            ),
            Text(widget.index,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.fade,
                )),
          ],
        ),
      ),
    );
  }
}
