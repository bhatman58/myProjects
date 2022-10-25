class TrendingModelTvResult {
  final String? backdropPath;
  final int? id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<int>? genreIds;
  final double? popularity;
  final String? firstAirDate;
  final double? voteAverage;

  TrendingModelTvResult({
    this.backdropPath,
    this.id,
    this.name,
    this.originalName,
    this.overview,
    this.posterPath,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
  });

  factory TrendingModelTvResult.fromJson(Map<String, dynamic> json) =>
      TrendingModelTvResult(
        backdropPath: json["backdrop_path"] as String,
        id: json["id"],
        name: json["name"] as String,
        originalName: json["original_name"] as String,
        overview: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        firstAirDate: json["first_air_date"] as String,
        voteAverage: json["vote_average"].toDouble(),
      );
}
