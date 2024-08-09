import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addEmployeeDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection('Employee').doc(id).set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future<void> updateEmployeeDetails(String id, Map<String, dynamic> employeeInfoMap) async {
    return await FirebaseFirestore.instance.collection('Employee').doc(id).update(employeeInfoMap);
  }

  Future<void> deleteEmployee(String id) async {
    return await FirebaseFirestore.instance.collection('Employee').doc(id).delete();
  }
}
