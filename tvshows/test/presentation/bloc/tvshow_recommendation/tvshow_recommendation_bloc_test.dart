import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tvshows/domain/usecases/get_tvshow_recommendations.dart';
import 'package:tvshows/presentation/bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';

import 'tvshow_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvshowRecommendations])
void main() {
  late MockGetTvshowRecommendations mockGetRecommendationTvshow;
  late RecommendationTvshowBloc recommendationTvshowBloc;

  setUp(() {
    mockGetRecommendationTvshow = MockGetTvshowRecommendations();
    recommendationTvshowBloc =
        RecommendationTvshowBloc(mockGetRecommendationTvshow);
  });

  final tTvshow = Tvshow(
    backdropPath: '/backdropPath',
    firstAirDate: '2021-01-01',
    genreIds: const [1, 2],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tId = 1;
  final tTvshowList = <Tvshow>[tTvshow];

  test('initial state must be empty', () {
    expect(recommendationTvshowBloc.state, TvshowsRecommendationLoading());
  });

  blocTest(
    'should emit[loading, tvshowHasData] when data is gotten succesfully',
    build: () {
      when(mockGetRecommendationTvshow.execute(tId))
          .thenAnswer((_) async => Right(tTvshowList));
      return recommendationTvshowBloc;
    },
    act: (RecommendationTvshowBloc bloc) =>
        bloc.add(FetchTvshowsRecommendationEvent(tId)),
    expect: () => [
      TvshowsRecommendationLoading(),
      TvshowsRecommendationHasData(tTvshowList)
    ],
  );

  blocTest(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetRecommendationTvshow.execute(tId)).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return recommendationTvshowBloc;
    },
    act: (RecommendationTvshowBloc bloc) =>
        bloc.add(FetchTvshowsRecommendationEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvshowsRecommendationLoading(),
      const TvshowsRecommendationHasError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetRecommendationTvshow.execute(tId)),
  );
}
