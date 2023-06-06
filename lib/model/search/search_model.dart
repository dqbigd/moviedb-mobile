import 'dart:convert';

import '../movie_model.dart';

MovieSearchResp movieSearchRespFromJson(String str) =>
    MovieSearchResp.fromJson(json.decode(str));

String movieSearchRespToJson(MovieSearchResp data) =>
    json.encode(data.toJson());

class MovieSearchResp {
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  MovieSearchResp({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieSearchResp.fromJson(Map<String, dynamic> json) =>
      MovieSearchResp(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
