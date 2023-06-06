import 'package:moviedb/model/detail/detail_model.dart';

import '../model/movie_model.dart';
import '../utils/constant.dart';
import 'base_client.dart';

class ApiNetwork {
  final String apiKey = Constant.token;

  // now playing
  Future<MovieResponse?> nowPlaying({int page = 1}) async {
    var apiUrl = '/movie/now_playing?api_key=$apiKey&page=$page';

    var response = await BaseClient().get(apiUrl);
    if (response != null) {
      return movieResponseFromJson(response);
    } else {
      return null;
    }
  }

  // detail movie
  Future<MovieDetail?> detailMovie(int id) async {
    var apiUrl = '/movie/$id?api_key=$apiKey';

    var response = await BaseClient().get(apiUrl);
    if (response != null) {
      return movieDetailFromJson(response);
    } else {
      return null;
    }
  }
}
