import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:login_form1/src/models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  Future<ItemModel> fetchmovieList() async {
    final postUrl = Uri.parse(
        'http://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e');
    Response response = await client.get(postUrl);
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
