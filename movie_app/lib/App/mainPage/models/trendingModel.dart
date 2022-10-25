import 'dart:convert';

import 'package:movie_app/App/mainPage/models/trendingModelResult.dart';

class TrendingModel {
  final int? page;
  final List<TrendingResult> results;
  final int? totalPages;
  final int? totalResults;
  TrendingModel({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory TrendingModel.fromJson(Map<dynamic, dynamic> json) => TrendingModel(
        page: json["page"],
        results: List<TrendingResult>.from(
            json["results"].map((x) => TrendingResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
