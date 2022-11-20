import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetDetailMovie;
  late MovieDetailBloc detailMovieBloc;

  setUp(() {
    mockGetDetailMovie = MockGetMovieDetail();
    detailMovieBloc = MovieDetailBloc(mockGetDetailMovie);
  });

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );

  final tId = 1;

  test('initial state must be empty', () {
    expect(detailMovieBloc.state, MovieDetailLoading());
  });

  blocTest('should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetDetailMovie.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (MovieDetailBloc bloc) => bloc.add(FetchMovieDetailEvent(tId)),
      expect: () => [MovieDetailLoading(), MovieDetailHasData(tMovieDetail)],
      verify: (bloc) {
        verify(mockGetDetailMovie.execute(tId));
        return FetchMovieDetailEvent(tId).props;
      });

  blocTest(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetDetailMovie.execute(tId)).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (MovieDetailBloc bloc) => bloc.add(FetchMovieDetailEvent(tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailHasError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetDetailMovie.execute(tId)),
  );
}
