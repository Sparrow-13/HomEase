// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/screens/checkOut1.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/Problems.dart';
import 'package:major_project/utils/categories.dart';
import 'package:major_project/utils/colors.dart';

class SpecificCategoryWidget extends StatefulWidget {
  dynamic title;

  SpecificCategoryWidget(this.title) {
    // print(title);
    // print(categoryOffers[title]);
    // print(categoryOffers[title].length);
  }

  @override
  State<SpecificCategoryWidget> createState() => _SpecificCategoryWidgetState();
}

class _SpecificCategoryWidgetState extends State<SpecificCategoryWidget> {
  late List<BookModel> selectedProblems = [];

  Future<void> showBottomPopUPMenu(List<dynamic> issue, int pos) async {
    List<bool> isSelected = List<bool>.filled(issue.length, false);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    child: MyIconWidget(
                  icon: Icons.shopping_cart,
                  message: '',
                  Backgroundcolor: white,
                  Iconsize: 24,
                  IconColor: Colors.white,
                )),
                Expanded(
                    child: Container(
                  width: 40,
                )),
                Container(
                  width: 60,
                  height: 5,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 168, 168, 168),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    print('loading cart');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cart(
                                  services: selectedProblems,
                                )));
                  },
                  child: Container(
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      child: MyIconWidget(
                        icon: Icons.shopping_cart,
                        message: '',
                        Backgroundcolor: lightred,
                        Iconsize: 24,
                        IconColor: Colors.black,
                      )),
                ),
              ]),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: issue.length,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        issue[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      duration: Duration(milliseconds: 300),
                    )),
                    contentPadding: EdgeInsets.all(10),
                    title: Text(issue[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (!isSelected[index]) {
                          setState(() {
                            selectedProblems.add(BookModel(
                                widget.title,
                                categoryOffers[widget.title][pos],
                                issue[index]));
                            isSelected[index] = !isSelected[index];

                            print("Updating selected problems...");
                          });
                        } else {
                          setState(() {
                            selectedProblems.removeWhere((BookModel) =>
                                BookModel.requestedservice == issue[index]);
                            isSelected[index] = !isSelected[index];
                            print("Updating selected problems...");
                          });
                        }
                      },

                      //return false when click
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected[index] ? Colors.lightBlue : Colors.green,
                      ),
                      child: Text(isSelected[index] ? 'Remove' : 'ADD'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


void _showModalSheet(List<dynamic> issue, int pos) {
  List<BookModel> selectedProblems = [];
  List<bool> isSelected = List<bool>.filled(issue.length, false);
  
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    child: MyIconWidget(
                  icon: Icons.shopping_cart,
                  message: '',
                  Backgroundcolor: white,
                  Iconsize: 24,
                  IconColor: Colors.white,
                )),
                Expanded(
                    child: Container(
                  width: 40,
                )),
                Container(
                  width: 60,
                  height: 5,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 168, 168, 168),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    print('loading cart');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cart(
                                  services: selectedProblems,
                                )));
                  },
                  child: Container(
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      child: MyIconWidget(
                        icon: Icons.shopping_cart,
                        message: '',
                        Backgroundcolor: lightred,
                        Iconsize: 24,
                        IconColor: Colors.black,
                      )),
                ),
              ]),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: issue.length,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        issue[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      duration: Duration(milliseconds: 300),
                    )),
                    contentPadding: EdgeInsets.all(10),
                    title: Text(issue[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (!isSelected[index]) {
                          setState(() {
                            selectedProblems.add(BookModel(
                                widget.title,
                                categoryOffers[widget.title][pos],
                                issue[index]));
                            isSelected[index] = !isSelected[index];

                            print("Updating selected problems...");
                          });
                        } else {
                          setState(() {
                            selectedProblems.removeWhere((BookModel) =>
                                BookModel.requestedservice == issue[index]);
                            isSelected[index] = !isSelected[index];
                            print("Updating selected problems...");
                          });
                        }
                      },

                      //return false when click
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected[index] ? Colors.lightBlue : Colors.green,
                      ),
                      child: Text(isSelected[index] ? 'Remove' : 'ADD'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
          },
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightgreen,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cart(
                                services: selectedProblems,
                              )));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                )),
          )
        ],
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: categoryOffers[widget.title].length,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () => _showModalSheet(
                        problems[categoryOffers[widget.title][index]], index),
                    contentPadding: EdgeInsets.all(10),
                    leading: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                            'images/${categoryOffers[widget.title][index]}.png')),
                    title: Text(categoryOffers[widget.title][index]),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
