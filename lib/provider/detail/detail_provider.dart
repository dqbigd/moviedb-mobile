import 'package:flutter/material.dart';

import '../../model/detail/detail_model.dart';
import '../../network/api_network.dart';

class DetailProvider extends ChangeNotifier {
  ApiNetwork apiNetwork = ApiNetwork();

  var isLoading = false;
  var responseMovieDetail = MovieDetail();

  void onInit(int id) {
    getDetailData(id);
  }

  getDetailData(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      MovieDetail? response = await apiNetwork.detailMovie(id);

      if (response != null) {
        responseMovieDetail = response;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
