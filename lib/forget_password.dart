import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_form1/global.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {
  final emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  reset() async {
    try {
      await firebaseAuth.sendPasswordResetEmail(
          email: emailcontroller.text.trim());
      Fluttertoast.showToast(msg: "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black38,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                validator: (value) {
                  if (value == null) {
                    return "Invalid Email";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      reset();
                    }
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
