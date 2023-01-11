import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => UserListState();
}

class UserListState extends State<UserList> {
  final _emailcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _imagecontroller = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('user');
  late Map<String, dynamic> addUsers;
  addUser() {
    addUsers = {
      'email': _emailcontroller.text,
      'phone': _phonecontroller.text,
      'profilepic': _imagecontroller.text,
    };
    ref.add(addUsers).whenComplete(
        () => Fluttertoast.showToast(msg: "Added to the Database"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users List',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index].data();
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage((doc as dynamic)['profilepic']),
                    ),
                    title: Text((doc as dynamic)['email']),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(doc['phone'])]),
                    trailing: IconButton(
                        onPressed: () {
                          _emailcontroller.text = doc['email'];
                          _phonecontroller.text = doc['phone'];

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: Text('Update User Details')),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _emailcontroller,
                                          decoration: const InputDecoration(
                                              hintText: 'Email'),
                                        ),
                                        TextField(
                                          controller: _phonecontroller,
                                          decoration: const InputDecoration(
                                              hintText: 'Phone'),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          'email': _emailcontroller.text,
                                          'phone': _phonecontroller.text,
                                        }).whenComplete(
                                                () => Navigator.pop(context));
                                      },
                                      child: const Text('Update'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        snapshot.data!.docs[index].reference
                                            .delete()
                                            .whenComplete(
                                                () => Navigator.pop(context));
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                  );
                },
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
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
                          controller: _imagecontroller,
                          decoration:
                              const InputDecoration(hintText: 'ImageUrl'),
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
                        addUser();
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
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
