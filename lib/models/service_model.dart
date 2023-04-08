// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:major_project/models/worker_model.dart';

class ServiceModel {
  WorkerModel workerModel;
  DateTime date;
  String ProblemDesc;
  ServiceModel(this.workerModel, this.date, this.ProblemDesc);
}

class OrderModel {
  String userName;
  String userAddress;
  String ProblemDesc;
  String time;
  String services;
  String serviceCategory;
  String serviceItem;
  OrderModel(this.userAddress, this.ProblemDesc, this.serviceCategory,
      this.serviceItem, this.services, this.time, this.userName);
}
