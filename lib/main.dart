import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_form1/forget_password.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/information_page.dart';
import 'package:login_form1/login_screen.dart';
import 'package:login_form1/signup_screen.dart';

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
        '/home': (context) => InformationPage(),
        '/reset': (context) => const ForgetPassword(),
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
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:login_form1/authenticaion_service.dart';
// import 'package:login_form1/home_page.dart';
// import 'package:login_form1/signup_screen.dart';


// void main() => runApp(MaterialApp(
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/register': (context) => const SignupPage(),
//         '/home': (context) => HomePage(),
//       },
//     ));

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _key = GlobalKey<FormState>();

//   final AuthenticationService _auth = AuthenticationService();

//   TextEditingController _emailContoller = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.deepPurple,
//         child: Center(
//           child: Form(
//             key: _key,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 30),
//                       TextFormField(
//                         controller: _emailContoller,
//                         validator: (value) {
//                           if (value!.isNotEmpty) {
//                             return 'Email cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: const InputDecoration(
//                             labelText: 'Email',
//                             labelStyle: TextStyle(color: Colors.white)),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       const SizedBox(height: 30),
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         validator: (value) {
//                           if (value!.isNotEmpty) {
//                             return 'Password cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: const InputDecoration(
//                             labelText: 'Password',
//                             labelStyle: TextStyle(color: Colors.white)),
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       TextButton(
//                         child: const Text('Not registerd? Sign up'),
//                         onPressed: () {
//                           Navigator.of(context).push(
//                             CupertinoPageRoute(
//                               fullscreenDialog: true,
//                               builder: (context) => const SignupPage(),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextButton(
//                             child: const Text('Login'),
//                             onPressed: () {
//                               if (_key.currentState!.validate()) {
//                                 signInUser();
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void signInUser() async {
//     dynamic authResult =
//         await _auth.loginUser(_emailContoller.text, _passwordController.text);
//     if (authResult == null) {
//       Fluttertoast.showToast(msg: 'Sign in error. could not be able to login');
//     } else {
//       _emailContoller.clear();
//       _passwordController.clear();
//       Navigator.pushNamed(context, '/dashboard');
//     }
//   }
// }
