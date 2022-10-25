import 'package:movie_app/App/detailsPage/models/trailerModelResult.dart';

class TrailerModel {
  final int? id;
  final List<TrailerModelResult>? results;

  TrailerModel({
    this.id,
    this.results,
  });

  factory TrailerModel.fromJson(Map<dynamic, dynamic> json) => TrailerModel(
        id: json["id"],
        results: List<TrailerModelResult>.from(
            json["results"].map((x) => TrailerModelResult.fromJson(x))),
      );
}
