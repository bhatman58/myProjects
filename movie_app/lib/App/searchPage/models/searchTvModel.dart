
import 'package:movie_app/App/searchPage/models/searchTvResult.dart';

class SearchTvModel {
  final int page;
  final List<SearchTvResult> results;
  final int? totalPages;
  final int? totalResults;

  SearchTvModel({
    this.page = 1,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory SearchTvModel.fromJson(Map<dynamic, dynamic> json) =>
      SearchTvModel(
        page: json["page"] as int,
        results: List<SearchTvResult>.from(
            json["results"].map((x) => SearchTvResult.fromJson(x))),
        totalPages: json["total_pages"] as int,
        totalResults: json["total_results"] as int,
      );
}