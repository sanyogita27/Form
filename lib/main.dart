import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_form1/forget_password.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/home_page.dart';
import 'package:login_form1/information_page.dart';
import 'package:login_form1/login_screen.dart';
import 'package:login_form1/signup_screen.dart';
import 'package:login_form1/user_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/reset': (context) => const ForgetPassword(),
        '/list': (context) => const UserList(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final User? firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, '/home'));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, '/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.waving_hand,
              color: Colors.white,
              size: 50,
            ),
            Text(
              "Hello There!!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
