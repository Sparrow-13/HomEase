import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/models/bookingModel.dart';
import 'package:major_project/models/service_model.dart';
import 'package:major_project/models/worker_model.dart';

class ServiceProvider with ChangeNotifier {
  void addServiceData({
    required WorkerModel workerModel,
    required DateTime date,
    required User? user,
    required String problemDesc,
  }) async {
    await FirebaseFirestore.instance
        .collection("userServices")
        .doc(user?.uid)
        .collection("YourServices")
        .doc(workerModel.workerName)
        .set({
      "workerName": workerModel.workerName,
      "workerAddress": workerModel.workerAddress,
      "workerImage": workerModel.workerImage,
      "ProblemDesc": problemDesc,
      "Date": DateUtils.dateOnly(DateTime.now()),
    });
  }

  void addServiceForWorker(
      {required WorkerModel workerModel,
      required User? user,
      required String problemDesc,
      required List<BookModel> services,
      required String time,
      required String userAddress}) async {
    await FirebaseFirestore.instance
        .collection("WorkerProfileServices")
        .doc(workerModel.workerName)
        .collection("YourOrders")
        .doc(user?.uid)
        .set({
      "userName": user?.displayName,
      "userAddress": userAddress,
      "ProblemDesc": problemDesc,
      "Date": DateUtils.dateOnly(DateTime.now()),
      "time": time,
      "services": services[0].requestedservice,
      "serviceCategory": services[0].Category,
      "serviceItem": services[0].serviceItem
    });
  }

  List<ServiceModel> allUserRequestsData = [];
  void fetchUserRequestsData() async {
    print("fetching requests");

    List<ServiceModel> newList = [];
    QuerySnapshot serviceData = await FirebaseFirestore.instance
        .collection("userServices")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourServices")
        .get();

    for (var element in serviceData.docs) {
      WorkerModel workerModel = WorkerModel(element.get("workerName"),
          element.get("workerImage"), 0, 0, element.get("workerAddress"), "");
      ServiceModel serviceModel = ServiceModel(workerModel,
          (element.get("Date")).toDate(), element.get("ProblemDesc"));

      newList.add(serviceModel);
    }

    allUserRequestsData = newList;
    notifyListeners();
  }

  List<OrderModel> allOrderRequestsData = [];
  void fetchWorkerOrderData() async {
    print("fetching orders");

    List<OrderModel> newList = [];
    QuerySnapshot serviceData = await FirebaseFirestore.instance
        .collection("WorkerProfileServices")
        .doc("Akshat Udeeniya")
        .collection("YourOrders")
        .get();

    for (var element in serviceData.docs) {
      OrderModel orderModel = OrderModel(
          element.get("userAddress"),
          element.get("ProblemDesc"),
          element.get("serviceCategory"),
          element.get("serviceItem"),
          element.get("services"),
          element.get("time"),
          element.get("userName"));
      newList.add(orderModel);
    }

    allOrderRequestsData = newList;
    // print(allOrderRequestsData);
    notifyListeners();
  }

  void deleteUserService({required String workerName}) async {
    QuerySnapshot serviceData = await FirebaseFirestore.instance
        .collection("userServices")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourServices")
        .get();

    for (var element in serviceData.docs) {
      if (element.id == workerName) {
        element.reference.delete();
      }
    }
    notifyListeners();
  }

  void deleteWorkerOrder({required String workerName}) async {
    QuerySnapshot orderData = await FirebaseFirestore.instance
        .collection("WorkerProfileServices")
        .doc(workerName)
        .collection("YourOrders")
        .get();

    for (var element in orderData.docs) {
      if (element.id == FirebaseAuth.instance.currentUser?.uid) {
        element.reference.delete();
      }
    }
    notifyListeners();
  }

  get getUserRequestsDataList {
    return allUserRequestsData;
  }

  get getWorkerOrderList {
    return allOrderRequestsData;
  }
}
