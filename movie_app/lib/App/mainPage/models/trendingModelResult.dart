class TrendingResult {
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final String? releaseDate;
  final double? voteAverage;
  final String? name;

  TrendingResult({
    this.backdropPath,
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.voteAverage,
    this.name,
  });

  factory TrendingResult.fromJson(Map<String, dynamic> json) => TrendingResult(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        voteAverage: json["vote_average"].toDouble(),
        name: json["name"],
      );
}
