import 'package:login_form1/src/models/item_model.dart';
import 'package:login_form1/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();
  Stream<ItemModel> get allMovies => _moviesFetcher.stream;
  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovie();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();























// class MoviesBloc {
//   final _repository = Repository();
//   final _moviesFetcher = PublishSubject<ItemModel>();
//   Stream<ItemModel> get allmovies => _moviesFetcher.stream;
  

//   //Observable<ItemModel> get allMovies => _moviesFetcher.stream;

//   fetchAllMovies() async {
//     ItemModel itemModel = await _repository.fetchAllMovie();
//     _moviesFetcher.sink.add(itemModel);
//   }

//   dispose() {
//     _moviesFetcher.close();
//   }
// }

// final bloc = MoviesBloc();
