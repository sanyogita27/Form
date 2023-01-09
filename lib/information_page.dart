import 'package:flutter/material.dart';
import 'package:login_form1/global.dart';
import 'package:login_form1/http_services.dart';
import 'package:login_form1/model.dart';

class InformationPage extends StatelessWidget {
  InformationPage({super.key});

  final HttpService httpService = HttpService();
  Future signOut() async {
    try {
      return firebaseAuth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
              onPressed: () async {
                await signOut().then((result) {
                  Navigator.of(context).pop(true);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasData) {
            List<UserModel>? users = snapshot.data;
            return ListView(
              children: users!
                  .map(
                    (UserModel users) => ListTile(
                        title: Text("${users.email}"),
                        subtitle: Text("${users.uid}"),
                        trailing: Text('${users.phone}'),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailInfo(users: users)))),
                  )
                  .toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
