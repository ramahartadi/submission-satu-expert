import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchlistStatusMovie,
  RemoveWatchlistMovie,
  SaveWatchlistMovie
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistStatusMovie mockGetWatchlistStatusMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovieMovies;
  late MockSaveWatchlistMovie mockSaveWatchlistMovieMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistStatusMovie = MockGetWatchlistStatusMovie();
    mockRemoveWatchlistMovieMovies = MockRemoveWatchlistMovie();
    mockSaveWatchlistMovieMovies = MockSaveWatchlistMovie();

    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
        mockGetWatchlistMovies,
        mockGetWatchlistStatusMovie,
        mockSaveWatchlistMovieMovies,
        mockRemoveWatchlistMovieMovies);
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

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, MovieWatchlistEmpty());
  });

  blocTest<WatchlistMovieBloc, MovieWatchlistState>(
    'should emit WatchlistMovieHasData when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },

    // act
    act: (WatchlistMovieBloc bloc) => bloc.add(FetchMovieWatchlistEvent()),
    // assert
    expect: () => <MovieWatchlistState>[
      MovieWatchlistLoading(),
      MovieWatchlistHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  blocTest<WatchlistMovieBloc, MovieWatchlistState>(
    'should emit WatchlistMovieError when data is get unsuccessful',
    // arrange
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },

    // act
    act: (WatchlistMovieBloc bloc) => bloc.add(FetchMovieWatchlistEvent()),
    // assert
    expect: () => <MovieWatchlistState>[
      MovieWatchlistLoading(),
      MovieWatchlistHasError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
  );

  group('Load Watchlist Movie', () {
    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieLoadWatchlistData when data is gotten successfully',
      // arrange
      build: () {
        when(mockGetWatchlistStatusMovie.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(LoadWatchlistMovieStatusEvent(tId)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        LoadWatchlistDataMovie(true),
      ],
      verify: (bloc) => verify(mockGetWatchlistStatusMovie.execute(tId)),
    );

    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieLoadWatchlistError when data is get unsuccessful',
      // arrange
      build: () {
        when(mockGetWatchlistStatusMovie.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(LoadWatchlistMovieStatusEvent(tId)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        LoadWatchlistDataMovie(false),
      ],
      verify: (bloc) => verify(mockGetWatchlistStatusMovie.execute(tId)),
    );
  });

  group('Save Watchlist Movie', () {
    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieSaveWatchlistData when data is gotten successfully',
      // arrange
      build: () {
        when(mockSaveWatchlistMovieMovies.execute(tMovieDetail)).thenAnswer(
            (_) async => Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(SaveWatchlistMovieEvent(tMovieDetail)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        WatchlistMovieMessage(WatchlistMovieBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) =>
          verify(mockSaveWatchlistMovieMovies.execute(tMovieDetail)),
    );

    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieSaveWatchlistMovieError when data is gotten successfully',
      // arrange
      build: () {
        when(mockSaveWatchlistMovieMovies.execute(tMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(SaveWatchlistMovieEvent(tMovieDetail)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        MovieWatchlistHasError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockSaveWatchlistMovieMovies.execute(tMovieDetail)),
    );
  });

  group('Remove Watchlist Movie', () {
    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieRemoveWatchlistData when data is gotten successfully',
      // arrange
      build: () {
        when(mockRemoveWatchlistMovieMovies.execute(tMovieDetail)).thenAnswer(
            (_) async => Right(WatchlistMovieBloc.watchlistAddSuccessMessage));
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(RemoveWatchlistMovieEvent(tMovieDetail)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        WatchlistMovieMessage(WatchlistMovieBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistMovieMovies.execute(tMovieDetail)),
    );

    blocTest<WatchlistMovieBloc, MovieWatchlistState>(
      'should emit MovieRemoveWatchlistMovieError when data is gotten successfully',
      // arrange
      build: () {
        when(mockRemoveWatchlistMovieMovies.execute(tMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },

      // act
      act: (WatchlistMovieBloc bloc) =>
          bloc.add(RemoveWatchlistMovieEvent(tMovieDetail)),
      // assert
      expect: () => <MovieWatchlistState>[
        MovieWatchlistLoading(),
        MovieWatchlistHasError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistMovieMovies.execute(tMovieDetail)),
    );
  });
}
