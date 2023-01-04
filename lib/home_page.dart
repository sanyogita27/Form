import 'package:flutter/material.dart';

import 'package:login_form1/global.dart';

import 'package:login_form1/room_finder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // signout() async {
  //   try {
  //     await firebaseAuth.signOut();

  //     Fluttertoast.showToast(msg: "Signout");
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.home,
                  size: 30,
                )
              ],
            ),
            const Text(
              "Room Finder",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const RoomFinder(),
    );
  }
}
