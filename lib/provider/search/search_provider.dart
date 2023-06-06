import 'package:flutter/material.dart';

import '../../model/movie_model.dart';
import '../../model/search/search_model.dart';
import '../../network/api_network.dart';

class SearchProvider extends ChangeNotifier {
  ApiNetwork apiNetwork = ApiNetwork();

  var isLoading = false;
  var responseMovie = MovieSearchResp();
  var listSearch = <Movie>[];

  void onInit(String query) {
    getDetailData(query);
  }

  getDetailData(String query) async {
    isLoading = true;
    notifyListeners();
    try {
      MovieSearchResp? response = await apiNetwork.searchMovie(query);
      if (response != null) {
        responseMovie = response;
        listSearch = responseMovie.results!;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
