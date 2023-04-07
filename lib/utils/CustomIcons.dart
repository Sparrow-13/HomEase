// ignore_for_file: non_constant_identifier_names ,    must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:major_project/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyIconWidget extends StatefulWidget {
  String message;
  Color Backgroundcolor = white;

   IconData? icon;
  double Iconsize = 32;
  Color IconColor;

  MyIconWidget(
      {super.key,
      this.message = '',
      this.Backgroundcolor = Colors.white,
      this.icon = Icons.error,
      this.IconColor = Colors.black,
      this.Iconsize = 24});

  @override
  State<MyIconWidget> createState() => _MyIconWidgetState();
}

class _MyIconWidgetState extends State<MyIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message,
      triggerMode: TooltipTriggerMode.tap,
      child: CircleAvatar(
          backgroundColor: widget.Backgroundcolor,
          radius: widget.Iconsize,
          child: Icon(
            widget.icon,
            color: widget.IconColor,
          )),
    );
  }
}
