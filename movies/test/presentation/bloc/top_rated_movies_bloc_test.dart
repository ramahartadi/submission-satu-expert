import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/bloc/list_movies/top_rated_movies_bloc.dart';

import 'popular_movies_bloc_test.mocks.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc popularMoviesBloc;
  late int listenerCallCount;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    popularMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
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

  blocTest<TopRatedMoviesBloc, MoviesState>(
    'should emit TopRatedMovieHasData when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetTopRatedMovies.execute())
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
    verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMoviesBloc, MoviesState>(
    'should emits error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
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

  blocTest<TopRatedMoviesBloc, MoviesState>(
    'should emits TopRatedMoviesEmpty state when data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
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
