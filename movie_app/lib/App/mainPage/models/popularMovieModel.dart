import 'package:movie_app/App/mainPage/models/PopularMovieResult.dart';

class PopularMovieModel {
  final int page;
  final List<PopularMovieResult> results;
  final int? totalPages;
  final int? totalResults;

  PopularMovieModel({
    this.page = 1,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PopularMovieModel.fromJson(Map<dynamic, dynamic> json) =>
      PopularMovieModel(
        page: json["page"] as int,
        results: (json['results'] as List)
            .map((e) => PopularMovieResult.fromJson(e))
            .toList(),
        // List<PopularMovieResult>.from(
        //     json["results"].map((x) => PopularMovieResult.fromJson(x))
        //     ),
        totalPages: json["total_pages"] as int,
        totalResults: json["total_results"] as int,
      );
}
