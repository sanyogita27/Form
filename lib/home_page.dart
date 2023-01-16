import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _emailcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  Future upadteData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc('fiOx9WnqgCPDw6uxPkpDLF27LP12')
        .update({
      'email': _emailcontroller.text,
      'phone': _phonecontroller.text,
    }).then((value) => Fluttertoast.showToast(msg: "updated data successfully"),
            onError: (e) =>
                Fluttertoast.showToast(msg: 'Error updating data: $e'));
  }

  // addUsers() async {
  //   await FirebaseFirestore.instance.collection('user').add({
  //     'email': _emailcontroller,
  //     'phone': _phonecontroller,
  //     'profilepic': imageUrl
  //   });
  // }

  // addUser() async {
  //   final User? firebaseUser = firebaseAuth.currentUser;
  //   try {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child("userimage")
  //         .child('${DateTime.now()}.jpg');
  //     await ref.putFile(imageFile!);
  //     imageUrl = await ref.getDownloadURL();
  //     await firebaseAuth.createUserWithEmailAndPassword(
  //         email: _emailcontroller.text.trim(),
  //         password: _passwordcontroller.text.trim());
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }

  //   if (firebaseUser != null) {
  //     String uid = firebaseUser.uid;

  //     UserModel usersmap = UserModel(
  //         uid: firebaseUser.uid,
  //         email: _emailcontroller.text,
  //         phone: _phonecontroller.text,
  //         profilepic: imageUrl);

  //     await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(uid)
  //         .set(usersmap.toMap())
  //         .then((value) {
  //       Fluttertoast.showToast(msg: "Account has been created");

  //       Navigator.pushNamed(context, '/login');
  //     });
  //   } else {
  //     Fluttertoast.showToast(msg: "Account has not been created");
  //     Navigator.pop(context);
  //   }
  // }

  Future deleteData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc('U1ZR4xSAzuRvriKDHSyhk674Dp03')
        .delete();
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Widget buildUser(UserModel user) => SizedBox(
  //       width: double.infinity,
  //       child: ListTile(
  //         leading: CircleAvatar(
  //             radius: 25, backgroundImage: NetworkImage(user.profilepic)),
  //         title: Text(
  //           user.phone,
  //         ),
  //         subtitle: Text(
  //           user.email,
  //         ),
  //         trailing: SizedBox(
  //           width: 100,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               IconButton(
  //                   onPressed: () {
  //                     openDialogueBox(context);
  //                   },
  //                   icon: const Icon(
  //                     Icons.edit,
  //                     color: Colors.black,
  //                   )),
  //               IconButton(
  //                   onPressed: () {
  //                     deleteData();
  //                   },
  //                   icon: const Icon(
  //                     Icons.delete,
  //                     color: Colors.black,
  //                   ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  Stream<List<UserModel>> getUsers() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: const Text("Users List"),
        actions: [
          IconButton(
              onPressed: () {
                openDialogueBox(context);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                await signOut().then((result) {
                  Navigator.popAndPushNamed(context, '/login');
                });
              },
              icon: const Icon(
                Icons.exit_to_app,
              )),
        ],
      ),
      // body: StreamBuilder<List<UserModel>>(
      //     stream: getUsers(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         final info = snapshot.data!;
      //         return ListView(
      //             //    children: info.map(buildUser).toList(),
      //             );
      //       } else if (snapshot.hasError) {
      //         return Text(
      //           "Something went wrong! ${snapshot.error}",
      //           style: const TextStyle(
      //             fontSize: 20,
      //           ),
      //         );
      //       } else {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     dialogueBox(context);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  openDialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit User Details'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  TextField(
                    controller: _phonecontroller,
                    decoration: const InputDecoration(hintText: 'Phone'),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  submitAction(context);
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  dialogueBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Text('Add Users')),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  TextField(
                    controller: _phonecontroller,
                    decoration: const InputDecoration(hintText: 'Phone'),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  addAction(context);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  submitAction(BuildContext context) {
    upadteData();
    _emailcontroller.clear();
    _phonecontroller.clear();
  }

  addAction(BuildContext context) {
    //addUsers();
    _emailcontroller.clear();
    _phonecontroller.clear();
  }
}
