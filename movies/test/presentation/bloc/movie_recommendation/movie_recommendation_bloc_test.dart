import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';

import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';

import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetRecommendationMovie;
  late RecommendationMovieBloc recommendationMovieBloc;

  setUp(() {
    mockGetRecommendationMovie = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetRecommendationMovie);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tId = 1;
  final tMovieList = <Movie>[tMovie];

  test('initial state must be empty', () {
    expect(recommendationMovieBloc.state, MoviesRecommendationLoading());
  });

  blocTest(
    'should emit[loading, movieHasData] when data is gotten succesfully',
    build: () {
      when(mockGetRecommendationMovie.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return recommendationMovieBloc;
    },
    act: (RecommendationMovieBloc bloc) =>
        bloc.add(FetchMoviesRecommendationEvent(tId)),
    expect: () => [
      MoviesRecommendationLoading(),
      MoviesRecommendationHasData(tMovieList)
    ],
  );

  blocTest(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId)).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return recommendationMovieBloc;
    },
    act: (RecommendationMovieBloc bloc) =>
        bloc.add(FetchMoviesRecommendationEvent(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MoviesRecommendationLoading(),
      const MoviesRecommendationHasError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetRecommendationMovie.execute(tId)),
  );
}
