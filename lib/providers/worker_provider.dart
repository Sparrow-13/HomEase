
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/models/worker_model.dart';

class WorkerProvider with ChangeNotifier {
  createProduct(QueryDocumentSnapshot element) {
    workerModel = WorkerModel(
        element.get("workerName"),
        element.get("workerImage"),
        element.get("workerAge"),
        element.get("workerRating"),
        element.get("workerAddress"),
        element.get("workerCategory"));

    // workerName: element.get("workerName"),
    // workerImage : element.get("workerName"),
    // workerAge : element.get("workerName"),
    // workerRating : element.get("workerName"),
    // workerAddress : element.get("workerName"),
    // workerCategory : element.get("workerName")
  }

  late WorkerModel workerModel;
  List<WorkerModel> carpenterWorkerList = [];
  List<WorkerModel> plumberWorkerList = [];
  List<WorkerModel> electricianWorkerList = [];

  // List<ProductModel> secondProductList = [];
  // List<ProductModel> thirdProductList = [];
  List<WorkerModel> allProductList = [];
  // late ProductModel productModel;

  fetchCarpentersData() async {
    List<WorkerModel> carpenterList = [];
    QuerySnapshot values =
        await FirebaseFirestore.instance.collection("Carpenter").get();
    //print(values);

    for (var element in values.docs) {
      createProduct(element);

      carpenterList.add(workerModel);
    }

    carpenterWorkerList = carpenterList;
    notifyListeners();
  }

  fetchPlumbersData() async {
    List<WorkerModel> plumberList = [];
    QuerySnapshot values =
        await FirebaseFirestore.instance.collection("Plumber").get();

    for (var element in values.docs) {
      //  print(element.data());
      createProduct(element);

      plumberList.add(workerModel);
    }

    plumberWorkerList = plumberList;
    notifyListeners();
  }

  fetchElectriciansData() async {
    List<WorkerModel> electricianList = [];
    QuerySnapshot values =
        await FirebaseFirestore.instance.collection("Electrician").get();

    for (var element in values.docs) {
      createProduct(element);

      electricianList.add(workerModel);
    }

    electricianWorkerList = electricianList;
    notifyListeners();
  }

  List<WorkerModel> get getCarpenterWorkerList {
    return carpenterWorkerList;
  }

  List<WorkerModel> get getPlumberWorkerList {
    return plumberWorkerList;
  }

  List<WorkerModel> get getElectricianWorkerList {
    return electricianWorkerList;
  }
}
