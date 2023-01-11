// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:login_form1/model.dart';

// class HttpService {
//   static const urlPrefix =
//       'https://firestore.googleapis.com/v1/projects/login-form-4286a/databases/user';
//   final postsUrl = Uri.parse('$urlPrefix/');
//   Future<List<UserModel>> getPosts() async {
//     Response res = await get(postsUrl);
//     if (res.statusCode == 200) {
//       List<dynamic> body = jsonDecode(res.body);
//       List<UserModel> users =
//           body.map((dynamic item) => UserModel.fromJson(item)).toList();

//       return users;
//     } else {
//       throw 'Unable to retrieve the information';
//     }
//   }

//   Future<void> deletePost() async {
//     Response res = await delete(postsUrl);
//     if (res.statusCode == 200) {
//       debugPrint('Deleted');
//     } else {
//       throw "Unable to delete";
//     }
//   }
// }

// class DetailInfo extends StatelessWidget {
//   final HttpService httpService = HttpService();
//   final UserModel users;

//   DetailInfo({super.key, required this.users});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('${users.uid}'),
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 // httpService.deletePost;
//               },
//               icon: const Icon(Icons.delete),
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: <Widget>[
//                 Card(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       ListTile(
//                         title: const Text("Email"),
//                         subtitle: Text('${users.email}'),
//                       ),
//                       ListTile(
//                         title: const Text("Phone"),
//                         subtitle: Text("${users.phone}"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
