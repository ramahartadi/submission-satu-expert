import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvshowModel = TvshowModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    originCountry: ["US"],
    originalLanguage: "en",
  );

  final tTvshow = Tvshow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'originalName',
  );

  test('should be a subclass of Tvshow entity', () async {
    final result = tTvshowModel.toEntity();
    expect(result, tTvshow);
  });
}
