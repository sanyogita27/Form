import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/model.dart';
import 'package:login_form1/progress_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  // final AuthenticationService _auth = AuthenticationService();
  // createUser() async {
  //   dynamic result = await _auth.createNewUser(
  //       _namecontroller.text, _emailcontroller.text, _passworrdcontroller.text);
  //   if (result == null) {
  //     Fluttertoast.showToast(msg: "Email is not valid");
  //   } else {
  //     _namecontroller.clear();
  //     _passworrdcontroller.clear();
  //     _emailcontroller.clear();
  //     Navigator.pop(context);
  //     debugPrint(result.toString());
  //   }
  // }

  File? imageFile;
  String? imageUrl;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Please choose an option"),
            title: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        _getFromCamera();
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.image,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passworrdcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _confirmcontroller = TextEditingController();

  saveInfo() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Processing...",
          );
        });

    final User? firebaseUser = firebaseAuth.currentUser;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("userimage")
          .child('${DateTime.now()}.jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passworrdcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      return e.message;
    }

    if (firebaseUser != null) {
      String uid = firebaseUser.uid;

      UserModel usersmap = UserModel(
          uid: firebaseUser.uid,
          email: _emailcontroller.text,
          phone: _phonecontroller.text,
          profilepic: imageUrl);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(usersmap.toMap())
          .then((value) {
        Fluttertoast.showToast(msg: "Account has been created");

        Navigator.pushNamed(context, '/login');
      });
    } else {
      Fluttertoast.showToast(msg: "Account has not been created");
      Navigator.pop(context);
    }
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      imageFile = File(croppedImage.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          "Signup Page",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _showImageDialog();
              },
              child: imageFile == null
                  ? const CircleAvatar()
                  : CircleAvatar(radius: 100, child: Image.file(imageFile!)),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phonecontroller,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Phone",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.length < 3) {
                          return "Invalid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.grey),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailcontroller,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            size: 25,
                            color: Colors.grey,
                          )),
                      validator: (value) {
                        if (value != null && !value.contains("@")) {
                          return "Email is Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.grey),
                      keyboardType: TextInputType.text,
                      controller: _passworrdcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                          )),
                      validator: (value) {
                        if (value != null && value.length < 6) {
                          return "Password is Required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      keyboardType: TextInputType.text,
                      controller: _confirmcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.vpn_key_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye)),
                      validator: (value) {
                        if (value != null &&
                            value != _passworrdcontroller.text) {
                          return "Wrong Password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    TextButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey)),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            saveInfo();
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
