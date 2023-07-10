class MovieDetailModel {
  final String title, posterPath, overview, releaseDate, backdropPath, homepage;
  final double voteAverage;
  final int voteCount, runtime;
  final List<dynamic> genres;
  static const String imageUrl = "https://image.tmdb.org/t/p/w500";

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = "$imageUrl${json['poster_path']}",
        overview = json['overview'],
        releaseDate = json['release_date'],
        backdropPath = "$imageUrl${json['backdrop_path']}",
        homepage = json['homepage'],
        voteAverage = json['vote_average'].toDouble(),
        voteCount = json['vote_count'],
        runtime = json['runtime'],
        genres = json['genres'];
}
