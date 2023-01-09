// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:login_form1/authenticaion_service.dart';
// import 'package:login_form1/database_manager.dart';
// import 'package:login_form1/global.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   final AuthenticationService _auth = AuthenticationService();

//   final _nameController = TextEditingController();
//   final _emailcontroller = TextEditingController();
//   final _gendercontroller = TextEditingController();

//   List userProfilesList = [];

//   String userID = "";

//   @override
//   void initState() {
//     super.initState();
//     fetchUserInfo();
//     fetchDatabaseList();
//   }

//   fetchUserInfo() async {
//     User? getUser = firebaseAuth.currentUser;
//     var userID = getUser!.uid;
//   }

//   fetchDatabaseList() async {
//     dynamic resultant = await DatabaseManager().getUsersList();

//     if (resultant == null) {
//       debugPrint('Unable to retrieve');
//     } else {
//       setState(() {
//         userProfilesList = resultant;
//       });
//     }
//   }

//   updateData(String name, String email, String gender, String userID) async {
//     await DatabaseManager().updateUserList(name, email, gender, userID);
//     fetchDatabaseList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.deepPurple,
//           automaticallyImplyLeading: false,
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 openDialogueBox(context);
//               },
//               child: const Icon(
//                 Icons.edit,
//                 color: Colors.white,
//               ),
//               // color: Colors.deepPurple,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await _auth.signOut().then((result) {
//                   Navigator.of(context).pop(true);
//                 });
//               },
//               child: const Icon(
//                 Icons.exit_to_app,
//                 color: Colors.white,
//               ),
//               // color: Colors.deepPurple,
//             )
//           ],
//         ),
//         body: Container(
//             child: ListView.builder(
//                 itemCount: userProfilesList.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(userProfilesList[index]['name']),
//                       subtitle: Text(userProfilesList[index]['email']),
//                       trailing: Text('${userProfilesList[index]['gender']}'),
//                     ),
//                   );
//                 })));
//   }

//   openDialogueBox(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Edit User Details'),
//             content: Container(
//               height: 150,
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(hintText: 'Name'),
//                   ),
//                   TextField(
//                     controller: _emailcontroller,
//                     decoration: const InputDecoration(hintText: 'Email'),
//                   ),
//                   TextField(
//                     controller: _gendercontroller,
//                     decoration: const InputDecoration(hintText: 'Gender'),
//                   )
//                 ],
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   submitAction(context);
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Submit'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Cancel'),
//               )
//             ],
//           );
//         });
//   }

//   submitAction(BuildContext context) {
//     updateData(_nameController.text, _emailcontroller.text,
//         _gendercontroller.text, userID);
//     _nameController.clear();
//     _emailcontroller.clear();
//     _gendercontroller.clear();
//   }
// }
