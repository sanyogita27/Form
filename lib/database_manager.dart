// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseManager {
//   final CollectionReference profileList =
//       FirebaseFirestore.instance.collection('profileInfo');

//   Future<void> createUserData(String email, String phone, String uid) async {
//     return await profileList.doc(uid).set({
//       'email': email,
//       'phone': phone,
//     });
//   }

//   Future updateUserList(String email, String phone, String uid) async {
//     return await profileList.doc(uid).update({'email': email, 'phone': phone});
//   }

//   Future getUsersList() async {
//     List itemsList = [];

//     try {
//       await profileList.get().then((querySnapshot) {
//         for (var element in querySnapshot.docs) {
//           itemsList.add(element.data());
//         }
//       });
//       return itemsList;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
