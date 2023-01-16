import 'package:login_form1/src/models/item_model.dart';
import 'package:login_form1/src/resources/movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();
  Future<ItemModel> fetchAllMovie() async => moviesApiProvider.fetchmovieList();
}
