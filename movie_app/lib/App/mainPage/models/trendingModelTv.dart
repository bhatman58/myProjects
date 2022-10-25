import 'dart:convert';

import 'package:movie_app/App/mainPage/models/trendingModelTvResult.dart';

class TrendingModelTv {
  final int? page;
  final List<TrendingModelTvResult> results;
  final int? totalPages;
  final int? totalResults;

  TrendingModelTv({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TrendingModelTv.fromJson(Map<dynamic, dynamic> json) =>
      TrendingModelTv(
        page: json["page"],
        results: List<TrendingModelTvResult>.from(
            json["results"].map((x) => TrendingModelTvResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
