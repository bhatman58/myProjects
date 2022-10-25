import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/App/detailsPage/models/movieDetailModel.dart';

import 'mocks/detailsPageControllerMock.dart';

void main() async {
  var controllerMock = DetailsPageControllerMock();
  test('details page controller test', () {
    when(() => controllerMock.getDetails(1046, true))
        .thenAnswer((_) => MovieDetailModel(title: 'changed'));

    var res = controllerMock.getDetails(1046, true);
    expect(res, isA<MovieDetailModel>());
  });
}
