class PopularMovieResult {
  final String? backdropPath;
  List<int>? genreIds;
  final int? id;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final double? voteAverage;

  PopularMovieResult({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
  });

  factory PopularMovieResult.fromJson(Map<String, dynamic> json) =>
      PopularMovieResult(
        backdropPath: json["backdrop_path"] as String,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x as int)),
        id: json["id"] as int,
        originalTitle: json["original_title"] as String,
        overview: json["overview"] as String,
        popularity: json["popularity"].toDouble() as double,
        posterPath: json["poster_path"] as String,
        releaseDate: json["release_date"] as String,
        title: json["title"] as String,
        voteAverage: json["vote_average"].toDouble() as double,
      );
}
