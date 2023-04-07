// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:major_project/providers/user_provider.dart';
import 'package:major_project/user/update_profile.dart';
import 'package:major_project/utils/CustomIcons.dart';
import 'package:major_project/utils/util.dart';
import 'package:major_project/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

ImagePicker _picker = ImagePicker();
UserModel? userModel;
String imageUrl = "";
//CollectionReference _reference = FirebaseFirestore.instance
//  .collection((FirebaseAuth.instance.currentUser?.uid).toString());
Future UploadImageToFirebase() async {
  XFile? file = await _picker.pickImage(source: ImageSource.gallery);
  if (file == null) return;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('userImages');
  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
  var urlRef = referenceRoot.child('userImages').child(uniqueFileName);
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await referenceImageToUpload.putFile(File(file.path));
    imageUrl = referenceImageToUpload.getDownloadURL().toString();
    var imgUrl = await urlRef.getDownloadURL();
    imageUrl = imgUrl;
    user?.updatePhotoURL(imageUrl);
    // print(imageUrl);
  } catch (err) {
    print(err);
  }
}

const double coverHeight = 120;
const double profileHeight = 144;
const top = coverHeight - profileHeight / 2 - 10;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProvider userProvider;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _getData());
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.fetchUserData();
    userModel = userProvider.getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    userModel = userProvider.getUserData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateProfile(userModel: userModel,))),
              ))
        ],
      ),
      body: userModel == null
          ? CircularProgressIndicator()
          : SafeArea(
              child: Container(
                color: white,
                child: ListView(children: [
                  _buildTop(),
                  _buildPersonalDetails(context),
                  // _buildContent(context),
                ]),
              ),
            ),
    );
  }
}

Widget _buildTop() {
  User? user = FirebaseAuth.instance.currentUser;
  return Container(
    padding: EdgeInsets.only(bottom: 25),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Container(
      //   width: double.infinity,
      //   // height: coverHeight,
      //   // child: Image.asset(
      //   //   "images/electrician.webp",
      //   //   fit: BoxFit.cover,
      //   // ),
      // ),

      // Positioned(
      //   top: top,
      //   child:
      Container(
        padding: EdgeInsets.only(top: 20),
        child: InkWell(
          onTap: () {
            UploadImageToFirebase();
          },
          child: CircleAvatar(
            radius: 78,
            backgroundColor: white,
            child: user?.photoURL != null
                ? Stack(children: [
                    CircleAvatar(
                      radius: 72,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage:
                          NetworkImage((user?.photoURL).toString()),
                    ),
                    // Positioned(
                    //     bottom: 0,
                    //     right: 0,
                    //     child: CircleAvatar(
                    //       backgroundColor: lightblue,
                    //       radius: 25,
                    //       child: Icon(
                    //         Icons.add_a_photo,
                    //         color: white,
                    //       ),
                    //     ))
                  ])
                : CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(18),
        child: Text(
          userModel != null && userModel!.userName != ""
              ? "${userModel?.userName.capitalize()}"
              : "Loading",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    ]),
  );
}

Widget _buildPersonalDetails(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Personal Details",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            )),
      ),
      Divider(
        thickness: 1, // thickness of the line
        indent: 20, // empty space to the leading edge of divider.
        endIndent: 20, // empty space to the trailing edge of the divider.
        color: Colors.grey, // The color to use when painting the line.
        height: 10, // The divider's height extent.
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            MyIconWidget(
              message: 'Phone',
              icon: Icons.phone,
              IconColor: Colors.blue,
            ),
            Text(
                userModel != null && userModel!.userPhone != ""
                    ? "+91-${userModel!.userPhone}"
                    : "Loading",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            MyIconWidget(
              message: 'email',
              icon: Icons.email,
              IconColor: Colors.red,
            ),
            Text('${user?.email} ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              MyIconWidget(
                message: 'Address',
                icon: Icons.location_on,
                IconColor: Colors.green,
              ),
              Expanded(
                child: Text(
                    userModel != null && userModel!.userAddress != ""
                        ? userModel!.userAddress
                        : "Loading",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              )
            ],
          ))
    ],
  );
}

// Widget _buildContent(BuildContext context) {
//   final user = FirebaseAuth.instance.currentUser;
//   return Column(
//     children: [
//       Text('${user?.email} userdata',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       SizedBox(
//         height: 20,
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//           userModel != null && userModel!.userName != ""
//               ? "Name : ${userModel?.userName}"
//               : "Please update your name",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//           userModel != null && userModel!.userAddress != ""
//               ? "Address : ${userModel!.userAddress}"
//               : "Please update address",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//           userModel != null && userModel!.userPhone != ""
//               ? "Phone no. : ${userModel!.userPhone}"
//               : "Please set phone no.",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//       SizedBox(
//         height: 20,
//       ),
//       ElevatedButton(
//           onPressed: () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => UpdateProfile())),
//           child: Text("Update Profile"))
//     ],
//   );
// }
