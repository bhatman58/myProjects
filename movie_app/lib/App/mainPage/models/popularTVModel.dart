import 'package:movie_app/App/mainPage/models/popularTVResult.dart';

class PopularTVModel {
  final int page;
  final List<PopularTVResult> results;
  final int? totalPages;
  final int? totalResults;

  PopularTVModel({
    this.page = 1,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory PopularTVModel.fromJson(Map<dynamic, dynamic> json) =>
      PopularTVModel(
        page: json["page"] as int,
        results: List<PopularTVResult>.from(
            json["results"].map((x) => PopularTVResult.fromJson(x))),
        totalPages: json["total_pages"] as int,
        totalResults: json["total_results"] as int,
      );
}
