import 'dart:async';
import 'package:movie_app/App/mainPage/models/popularTVModel.dart';
import 'package:movie_app/App/mainPage/models/popularTVResult.dart';
import 'package:movie_app/App/mainPage/models/trendingModel.dart';
import 'package:movie_app/App/mainPage/models/trendingModelResult.dart';
import 'package:movie_app/App/mainPage/models/trendingModelTv.dart';
import 'package:movie_app/App/mainPage/models/trendingModelTvResult.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/App/mainPage/models/popularMovieModel.dart';
import 'package:movie_app/App/mainPage/models/PopularMovieResult.dart';
import 'mocks/controllerMock.dart';

// class TMDBMOCK extends Mock implements TMDB {}

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group('Testing All The Main Page Movie/Tv Controllers', () {
    var controllerMock = ControllerMock();
    test('testing main page popular movies', () async {
      when(() => controllerMock.getPopularMoviesStreamingMainPage())
          .thenAnswer((invocation) => PopularMovieModel(results: [
                PopularMovieResult(
                  backdropPath: "/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg",
                  genreIds: [27, 53],
                  id: 760161,
                  overview:
                      "After escaping from an Estonian psychiatric facility, Leena Klammer travels to America by impersonating Esther, the missing daughter of a wealthy family. But when her mask starts to slip, she is put against a mother who will protect her family from the murderous “child” at any cost.",
                  popularity: 3876.772,
                  posterPath: "/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg",
                  releaseDate: "2022-07-27",
                  title: "Orphan: First Kill",
                  voteAverage: 6.8,
                )
              ]));

      PopularMovieModel res = controllerMock
          .getPopularMoviesStreamingMainPage(); //controllerMock.getPopularMoviesStreamingMainPage();
      expect(res.results[0], isA<PopularMovieResult>());
    });

    test('testing main page popular Tvs', () async {
      when(() => controllerMock.getPopularTVMainPage())
          .thenAnswer((invocation) => PopularTVModel(results: [
                PopularTVResult(
                  backdropPath: "/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg",
                  genreIds: [27, 53],
                  id: 760161,
                  overview:
                      "After escaping from an Estonian psychiatric facility, Leena Klammer travels to America by impersonating Esther, the missing daughter of a wealthy family. But when her mask starts to slip, she is put against a mother who will protect her family from the murderous “child” at any cost.",
                  popularity: 3876.772,
                  posterPath: "/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg",
                  firstAir: "2022-07-27",
                  originalName: "Orphan: First Kill",
                  voteAverage: 6.8,
                )
              ]));

      PopularTVModel res = controllerMock
          .getPopularTVMainPage(); //controllerMock.getPopularMoviesStreamingMainPage();
      expect(res.results[0], isA<PopularTVResult>());
    });

    test('testing main page trending movies', () async {
      when(() => controllerMock.getTrendingMainPage('Day'))
          .thenAnswer((invocation) => TrendingModel(results: [
                TrendingResult(
                  backdropPath: "/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg",
                  genreIds: [27, 53],
                  id: 760161,
                  overview:
                      "After escaping from an Estonian psychiatric facility, Leena Klammer travels to America by impersonating Esther, the missing daughter of a wealthy family. But when her mask starts to slip, she is put against a mother who will protect her family from the murderous “child” at any cost.",
                  popularity: 3876.772,
                  posterPath: "/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg",
                  releaseDate: "2022-07-27",
                  title: "Orphan: First Kill",
                  voteAverage: 6.8,
                )
              ]));

      TrendingModel res = controllerMock.getTrendingMainPage('Day');
      expect(res.results[0], isA<TrendingResult>());
    });

    test('testing main page trending Tvs', () async {
      when(() => controllerMock.getTrendingMainPageTv('Day'))
          .thenAnswer((invocation) => TrendingModelTv(results: [
                TrendingModelTvResult(
                  backdropPath: "/5GA3vV1aWWHTSDO5eno8V5zDo8r.jpg",
                  genreIds: [27, 53],
                  id: 760161,
                  overview:
                      "After escaping from an Estonian psychiatric facility, Leena Klammer travels to America by impersonating Esther, the missing daughter of a wealthy family. But when her mask starts to slip, she is put against a mother who will protect her family from the murderous “child” at any cost.",
                  popularity: 3876.772,
                  posterPath: "/pHkKbIRoCe7zIFvqan9LFSaQAde.jpg",
                  firstAirDate: "2022-07-27",
                  originalName: "Orphan: First Kill",
                  voteAverage: 6.8,
                )
              ]));

      TrendingModelTv res = await controllerMock.getTrendingMainPageTv('Day');
      expect(res.results[0], isA<TrendingModelTvResult>());
    });
  });
}
