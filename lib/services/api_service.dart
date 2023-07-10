import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

enum MovieUrlType {
  popular,
  nowPlaying,
  comingSoon,
}

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String detailBaseUrl = "$baseUrl/movie?id=";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";

  static Future<List<MovieModel>> getMovies(MovieUrlType movieUrlType) async {
    List<MovieModel> movieInstances = [];
    final Uri url;
    if (movieUrlType == MovieUrlType.popular) {
      url = Uri.parse("$baseUrl/$popular");
    } else if (movieUrlType == MovieUrlType.nowPlaying) {
      url = Uri.parse("$baseUrl/$nowPlaying");
    } else {
      url = Uri.parse("$baseUrl/$comingSoon");
    }
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      if (movieUrlType == MovieUrlType.nowPlaying ||
          movieUrlType == MovieUrlType.comingSoon) {
        movieInstances.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetail(int id) async {
    final Uri url = Uri.parse("$detailBaseUrl$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
