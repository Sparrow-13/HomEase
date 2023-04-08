// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:flutter/material.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/utils/colors.dart';
import 'package:major_project/worker/workerProfile.dart';

class SingleProduct extends StatelessWidget {
  final String name;
  final String image;
  final String address;
  final int age;
  final int rating;
  final String category;
  final List<BookModel> services;
  final String time;
  final String userAddress;
  const SingleProduct({
    super.key,
    required this.name,
    required this.image,
    required this.address,
    required this.age,
    required this.rating,
    required this.category,
    required this.services,
    required this.time,
    required this.userAddress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkerProfile(
                    name: name,
                    address: address,
                    category: category,
                    rating: rating,
                    age: age,
                    image: image,
                    services: services,
                    time: time,
                    userAddress: userAddress,
                  ))),
      child: Container(
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 2, color: Colors.black12)),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              InkWell(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => WorkerProfile(
                //             name: name,
                //             address: address,
                //             category: category,
                //             rating: rating,
                //             age: age,
                //             image: image))),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Address : $address",
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Age : $age"),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Color.fromARGB(255, 247, 190, 4),
                    ),
                    Text(
                      "$rating",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
