import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static Future addUsersData(Map<String, dynamic> userInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfo);
  }

  static Future getAllUsers() async{
    return await FirebaseFirestore.instance.collection('users').snapshots();
  }

  static Future updateUserDetail(String id, Map<String, dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).update(updateInfo);
  }

  static Future deleteData(String id) async{
    return await FirebaseFirestore.instance.collection('users').doc(id).delete();
  }
}
