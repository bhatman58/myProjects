class SearchTvResult {
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

  SearchTvResult(
      {this.backdropPath,
      this.genreIds,
      this.id,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.firstAir,
      this.name,
      this.voteAverage,
      this.isMovie});

  factory SearchTvResult.fromJson(Map<String, dynamic> json) => SearchTvResult(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAir: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        isMovie: false,
      );
}
