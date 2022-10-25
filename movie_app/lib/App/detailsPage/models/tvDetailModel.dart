import 'dart:convert';
import 'package:movie_app/App/detailsPage/models/genres.dart';

class TvDetailModel {
  bool? adult;
  String? backdropPath;
  String? firstAirDate;
  List<Genres>? genres;
  int? id;
  bool? inProduction;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? status;
  double? voteAverage;

  TvDetailModel({
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    this.genres,
    this.id,
    this.inProduction,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.status,
    this.voteAverage,
  });

  factory TvDetailModel.fromJson(Map<dynamic, dynamic> json) => TvDetailModel(
        adult: json["adult"] as bool,
        backdropPath: json["backdrop_path"] as String,
        firstAirDate: json["first_air_date"] as String,
        genres:
            List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
        id: json["id"] as int,
        inProduction: json["in_production"] as bool,
        name: json["name"] as String,
        numberOfEpisodes: json["number_of_episodes"] as int,
        numberOfSeasons: json["number_of_seasons"] as int,
        originalName: json["original_name"] as String,
        overview: json["overview"] as String,
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] as String,
        status: json["status"] as String,
        voteAverage: json["vote_average"].toDouble(),
      );
}
