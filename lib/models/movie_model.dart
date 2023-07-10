class MovieModel {
  final String title, overview, posterPath;
  final int id;
  final bool adult;
  final List<dynamic> genreIds;
  static const String imageUrl = "https://image.tmdb.org/t/p/w500";
  DateTime releaseDate;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        posterPath = "$imageUrl${json['poster_path']}",
        id = json['id'],
        adult = json['adult'],
        genreIds = json['genre_ids'],
        releaseDate = DateTime.parse(json['release_date']);
}
