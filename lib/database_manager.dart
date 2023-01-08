import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

  Future<void> createUserData(
      String name, String email, String gender, String uid) async {
    return await profileList
        .doc(uid)
        .set({'name': name, 'email': email, 'gender': gender});
  }

  Future updateUserList(
      String name, String email, String gender, String uid) async {
    return await profileList
        .doc(uid)
        .update({'name': name, 'email': email, 'gender': gender});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.data());
        }
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
