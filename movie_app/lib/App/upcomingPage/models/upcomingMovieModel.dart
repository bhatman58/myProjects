import 'package:movie_app/App/searchPage/models/searchMovieResult.dart';
import 'package:movie_app/App/upcomingPage/models/upcomingMovieModelResult.dart';

class UpcomingMovieModel {
  final int page;
  final List<UpcomingMovieModelResult> results;
  final int? totalPages;
  final int? totalResults;

  UpcomingMovieModel({
    this.page = 1,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory UpcomingMovieModel.fromJson(Map<dynamic, dynamic> json) =>
      UpcomingMovieModel(
        page: json["page"] as int,
        results: (json['results'] as List)
            .map((e) => UpcomingMovieModelResult.fromJson(e))
            .toList(),
        totalPages: json["total_pages"] as int,
        totalResults: json["total_results"] as int,
      );
}
