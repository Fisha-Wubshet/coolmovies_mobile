import 'package:flutter/foundation.dart';

import '../model/model.dart';

class MovieListProvider with ChangeNotifier {

List<Movie> _movies = [];
List<Movie> get movies => _movies;

  void updateMovies(List<Movie> newMovies){
    _movies = newMovies;
    notifyListeners();
  }

}
