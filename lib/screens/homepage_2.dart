// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/book_worker/my_services.dart';
import 'package:major_project/screens/widgets/userdrawer.dart';
import 'package:major_project/screens/widgets/image_slider.dart';
import 'package:major_project/user/user_profile.dart';
import 'package:major_project/utils/CustomContainer.dart';

import 'package:major_project/utils/categories.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// String userImage = "";

class HomePage2 extends StatefulWidget {
  int index;
  HomePage2(this.index) {
    print(index);
  }

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
            key: _key,
            drawer: MyDrawer(user, context),
            body: SafeArea(
                // width: double.infinity,
                // height: double.infinity,
                // color: Color.fromARGB(255, 245, 245, 245),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _key.currentState?.openDrawer(),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.black,
                                    )),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28,
                                      child: IconButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyServices())),
                                        icon: Icon(Icons.shop_2,
                                            color: Colors.black),
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfile())),
                                    child: user.photoURL != null
                                        ? CircleAvatar(
                                            radius: 28,
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            backgroundImage: NetworkImage(
                                                (user.photoURL).toString()),
                                          )
                                        : CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.add_a_photo,
                                                size: 33, color: Colors.black),
                                          ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello",
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                user.displayName == ""
                                    ? Text(
                                        "${user.email?.split('@')[0]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "${user.displayName}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ImageSlider(),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Services',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          // Divider(
                          //   thickness: 1, // thickness of the line
                          //   indent: 0, // empty space to the leading edge of divider.
                          //   endIndent:
                          //       0, // empty space to the trailing edge of the divider.
                          //   color:
                          //       Colors.black, // The color to use when painting the line.
                          //   height: 10, // The divider's height extent.
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 5,
                              alignment: WrapAlignment.spaceAround,
                              // runAlignment: WrapAlignment.spaceAround,
                              children: <Widget>[
                                for (int i = 0; i < categories.length;i++)
                                  CustomContainer(categories[i], counter++ % 5, 110,
                                      110, CategoriesIcons[categories[i]]),
                                // CustomContainer('View More', counter, 110, 110,
                                //     MdiIcons.dotsHorizontalCircle)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   WorkerList(category: 'Carpenter')),
                    //         );
                    //       },
                    //       child: Container(
                    //         height: 140,
                    //         width: 140,
                    //         decoration: BoxDecoration(
                    //             color: lightblue,
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             MyIconWidget(
                    //                 message: '',
                    //                 Backgroundcolor: white,
                    //                 icon: MdiIcons.handSaw),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text('Carpenter',
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.w600)),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   WorkerList(category: 'Plumber')),
                    //         );
                    //       },
                    //       child: Container(
                    //         height: 140,
                    //         width: 140,
                    //         decoration: BoxDecoration(
                    //             color: lightviolet,
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             MyIconWidget(
                    //                 message: '',
                    //                 Backgroundcolor: white,
                    //                 icon: MdiIcons.pipeValve),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text('Plumber',
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.w600)),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   WorkerList(category: 'Electrician')),
                    //         );
                    //       },
                    //       child: Container(
                    //         height: 140,
                    //         width: 140,
                    //         decoration: BoxDecoration(
                    //             color: lightgreen,
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             MyIconWidget(
                    //                 message: '',
                    //                 Backgroundcolor: white,
                    //                 icon: MdiIcons.lightningBolt),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text('Electrician',
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.w600)),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => MainCategoryPage()),
                    //         );
                    //       },
                    //       child: Container(
                    //         height: 140,
                    //         width: 140,
                    //         decoration: BoxDecoration(
                    //             color: lightred, //rgb(255, 159, 159)
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             CircleAvatar(
                    //                 backgroundColor: Colors.white,
                    //                 radius: 28,
                    //                 child: Icon(
                    //                   MdiIcons.dotsHorizontalCircle,
                    //                   color: Colors.black,
                    //                 )),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text('view more',
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.w600)),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // )
                    ))));
  }
}

// Future checkUserData() async {
//   QuerySnapshot value = await FirebaseFirestore.instance
//       .collection((FirebaseAuth.instance.currentUser?.uid).toString())
//       .get();
//   value.docs.forEach(
//     (element) {
//       if (element.get('userImage') != null) {
//         userImage = element.get('userImage');
//       }
//       print(userImage);
//     },
//   );
// }
