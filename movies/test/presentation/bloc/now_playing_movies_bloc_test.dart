import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/bloc/list_movies/now_playing_movies_bloc.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesBloc popularMoviesBloc;
  late int listenerCallCount;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    popularMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
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

  final tMovieList = <Movie>[tMovie];

  blocTest<NowPlayingMoviesBloc, MoviesState>(
    'should emit NowPlayingMovieHasData when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },

    // act
    act: (bloc) => bloc.add(OnListMoviesCalled()),
    // assert
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
  );

  blocTest<NowPlayingMoviesBloc, MoviesState>(
    'should emits error when data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnListMoviesCalled()),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesError('Server Failure'),
    ],
    verify: (bloc) => MoviesLoading(),
  );

  blocTest<NowPlayingMoviesBloc, MoviesState>(
    'should emits NowPlayingMoviesEmpty state when data is empty',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnListMoviesCalled()),
    expect: () => <MoviesState>[
      MoviesLoading(),
      MoviesEmpty(),
    ],
  );
}
