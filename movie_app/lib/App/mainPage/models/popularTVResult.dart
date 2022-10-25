class PopularTVResult {
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAir;
  final String? name;
  final double? voteAverage;
  final bool? isMovie;

  PopularTVResult({
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAir,
    this.name,
    this.voteAverage,
    this.isMovie
  });

  factory PopularTVResult.fromJson(Map<String, dynamic> json) =>
      PopularTVResult(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x as int)),
        id: json["id"] as int,
        originalName: json["original_name"] as String,
        overview: json["overview"] as String,
        popularity: json["popularity"].toDouble() as double,
        posterPath: json["poster_path"] as String,
        firstAir: json["first_air_date"] as String,
        name: json["name"] as String,
        voteAverage: json["vote_average"].toDouble() as double,
        isMovie: false,
      );
}
