import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // void signInUser() async {
  //   dynamic authResult =
  //       await _auth.loginUser(emailcontroller.text, passwordcontroller.text);
  //   if (authResult == null) {
  //     debugPrint('Sign in error. could not be able to login');
  //   } else {
  //     emailcontroller.clear();
  //     passwordcontroller.clear();
  //     Navigator.pushNamed(context, '/home');
  //   }
  // }

  logininfo() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Processing...",
          );
        });

    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((value) {
        emailcontroller.clear();
        passwordcontroller.clear();
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushNamed(context, '/home');
      });
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Center(
            child: Text(
              "Login Page",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      prefixIcon: Icon(
                        Icons.email,
                        size: 25,
                        color: Colors.grey,
                      ),
                      hintText: ("Email"),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                  validator: (value) {
                    if (value == null) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  style: const TextStyle(color: Colors.grey),
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: "password",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.vpn_key_sharp,
                      size: 25,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/reset');
                        },
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        backgroundColor: MaterialStatePropertyAll(Colors.grey)),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        logininfo();
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Do not have an account? SignUp",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ))
              ],
            ),
          ),
        ));
  }
}
