import 'package:movie_app/App/searchPage/models/searchMovieResult.dart';

class SearchMovieModel {
  final int page;
  final List<SearchMovieResult> results;
  final int? totalPages;
  final int? totalResults;

  SearchMovieModel({
    this.page = 1,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SearchMovieModel.fromJson(Map<dynamic, dynamic> json) =>
      SearchMovieModel(
        page: json["page"] as int,
        results: (json['results'] as List)
            .map((e) => SearchMovieResult.fromJson(e))
            .toList(),
        totalPages: json["total_pages"] as int,
        totalResults: json["total_results"] as int,
      );
}
