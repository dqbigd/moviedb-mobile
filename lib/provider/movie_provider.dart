import 'package:flutter/material.dart';
import 'package:moviedb/model/movie_model.dart';

import '../network/api_network.dart';

class HomeProvider extends ChangeNotifier {
  ApiNetwork apiNetwork = ApiNetwork();

  var isLoading = false;
  var category = '';

  var listNowPlaying = <Movie>[];
  var respNowPlaying = MovieResponse();

  HomeProvider() {
    onInit();
  }

  void onInit() {
    getNowPlayingData();
  }

  getNowPlayingData({int? page}) async {
    isLoading = true;
    notifyListeners();
    try {
      MovieResponse? response = await apiNetwork.nowPlaying();

      if (response != null) {
        respNowPlaying = response;
        listNowPlaying = respNowPlaying.results!;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
