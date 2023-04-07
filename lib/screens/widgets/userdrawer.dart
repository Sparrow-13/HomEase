// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../user/user_profile.dart';
import '../../utils/colors.dart';

Widget MyDrawer(User user, BuildContext context) {
  return Drawer(
    backgroundColor: white,
    elevation: 0,
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: user.displayName == ""
                    ? Text(
                        "${user.email?.split('@')[0].toUpperCase()}",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    : Text("${user.displayName}",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                accountEmail: Text(user.email!,
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile()));
                  },
                  child: user.photoURL != null
                      ? CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.grey.shade800,
                          backgroundImage:
                              NetworkImage((user.photoURL).toString()),
                        )
                      : CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 33,
                          ),
                        ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                ),
              ),
              ListTile(
                selected: true,
                leading: Icon(
                  size: 25,
                  Icons.home,
                  color: Colors.green,
                ),
                title: Text("Home",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
              ListTile(
                leading: Icon(
                  size: 25,
                  Icons.book,
                  color: Colors.blue,
                ),
                title: Text("Bookings",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
              ListTile(
                leading: Icon(
                  size: 25,
                  Icons.info,
                  color: Colors.yellow,
                ),
                title: Text("About Us",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
              ListTile(
                leading: Icon(
                  size: 25,
                  Icons.remove_circle_rounded,
                  color: Colors.red,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text("Are you sure you want to Logout?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            //return false when click on "NO"
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop(true);
                            },
                            //return true when click on "Yes"
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text('Log Out'),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: Text("Logout",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(bottom: 20),
            // This align moves the children to the bottom
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                    child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 25,
                        color: Colors.red,
                      ),
                      title: Text('Exit Application'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Exit App'),
                              content: Text('Do you want to exit an App?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  //return false when click on "NO"
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: Text('No'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  //return true when click on "Yes"
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ],
                ))))
      ],
    ),
  );
}
