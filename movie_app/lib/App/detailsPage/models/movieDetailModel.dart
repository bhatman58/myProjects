import 'dart:convert';
import 'package:movie_app/App/detailsPage/models/genres.dart';

class MovieDetailModel {
  bool? adult;
  String? backdropPath;
  List<Genres>? genres;
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? status;
  String? title;
  double? voteAverage;

  MovieDetailModel({
    this.adult,
    this.backdropPath,
    this.genres,
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.status,
    this.title,
    this.voteAverage,
  });

  factory MovieDetailModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieDetailModel(
        adult: json["adult"] as bool,
        backdropPath: json["backdrop_path"] as String,
        genres:
            List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
        id: json["id"] as int,
        overview: json["overview"] as String,
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] as String,
        releaseDate: json["release_date"] as String,
        status: json["status"] as String,
        title: json["title"] as String,
        voteAverage: json["vote_average"].toDouble(),
      );
}
