import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tvshows/domain/entities/tvshow_detail.dart';
import 'package:tvshows/domain/usecases/get_watchlist_status_tvshows.dart';
import 'package:tvshows/domain/usecases/get_watchlist_tvshows.dart';
import 'package:tvshows/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:tvshows/domain/usecases/save_watchlist_tvshow.dart';
import 'package:tvshows/presentation/bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';

import 'tvshow_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTv, GetWatchlistStatusTv, RemoveWatchlistTv, SaveWatchlistTv])
void main() {
  late WatchListTvshowBloc watchlistTvshowBloc;
  late MockGetWatchlistTvshows mockGetWatchlistTvshows;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlistTvshows;
  late MockSaveWatchlist mockSaveWatchlistTvshows;

  setUp(() {
    mockGetWatchlistTvshows = MockGetWatchlistTvshows();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlistTvshows = MockRemoveWatchlist();
    mockSaveWatchlistTvshows = MockSaveWatchlist();

    mockGetWatchlistTvshows = MockGetWatchlistTvshows();
    watchlistTvshowBloc = WatchListTvshowBloc(
        mockGetWatchlistTvshows,
        mockGetWatchListStatus,
        mockSaveWatchlistTvshows,
        mockRemoveWatchlistTvshows);
  });

  final tTvshow = Tvshow(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    overview:
        'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    voteAverage: 7.91,
    voteCount: 1172,
    firstAirDate: "2011-04-17",
    name: "Game of Thrones",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'Game of Thrones',
  );

  final tTvshowDetail = TvshowDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    homepage: "http://www.hbo.com/game-of-thrones",
    inProduction: false,
    lastAirDate: "2019-05-19",
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originalLanguage: 'en',
    popularity: 369.594,
    status: 'Ended',
    tagline: 'Winter Is Coming',
    type: 'Scripted',
  );

  final tId = 1;

  final tTvshowList = <Tvshow>[tTvshow];

  test('initial state should be empty', () {
    expect(watchlistTvshowBloc.state, TvshowWatchlistEmpty());
  });

  blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
    'should emit WatchListTvshowHasData when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetWatchlistTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      return watchlistTvshowBloc;
    },

    // act
    act: (WatchListTvshowBloc bloc) => bloc.add(FetchTvshowWatchlistEvent()),
    // assert
    expect: () => <TvshowWatchlistState>[
      TvshowWatchlistLoading(),
      TvshowWatchlistHasData(tTvshowList),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvshows.execute()),
  );

  blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
    'should emit WatchListTvshowError when data is get unsuccessful',
    // arrange
    build: () {
      when(mockGetWatchlistTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvshowBloc;
    },

    // act
    act: (WatchListTvshowBloc bloc) => bloc.add(FetchTvshowWatchlistEvent()),
    // assert
    expect: () => <TvshowWatchlistState>[
      TvshowWatchlistLoading(),
      TvshowWatchlistHasError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistTvshows.execute()),
  );

  group('Load Watchlist Tvshow', () {
    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowLoadWatchListData when data is gotten successfully',
      // arrange
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(LoadWatchlistTvshowStatus(tId)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        LoadWatchlistData(true),
      ],
      verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
    );

    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowLoadWatchlistError when data is get unsuccessful',
      // arrange
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(LoadWatchlistTvshowStatus(tId)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        LoadWatchlistData(false),
      ],
      verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
    );
  });

  group('Save Watchlist Tvshow', () {
    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowSaveWatchListData when data is gotten successfully',
      // arrange
      build: () {
        when(mockSaveWatchlistTvshows.execute(tTvshowDetail)).thenAnswer(
            (_) async => Right(WatchListTvshowBloc.watchlistAddSuccessMessage));
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(SaveWatchlistTvshow(tTvshowDetail)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        WatchlistTvshowMessage(WatchListTvshowBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) => verify(mockSaveWatchlistTvshows.execute(tTvshowDetail)),
    );

    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowSaveWatchlistError when data is gotten successfully',
      // arrange
      build: () {
        when(mockSaveWatchlistTvshows.execute(tTvshowDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(SaveWatchlistTvshow(tTvshowDetail)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        TvshowWatchlistHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockSaveWatchlistTvshows.execute(tTvshowDetail)),
    );
  });

  group('Remove Watchlist Tvshow', () {
    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowRemoveWatchListData when data is gotten successfully',
      // arrange
      build: () {
        when(mockRemoveWatchlistTvshows.execute(tTvshowDetail)).thenAnswer(
            (_) async => Right(WatchListTvshowBloc.watchlistAddSuccessMessage));
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(RemoveWatchlistTvshow(tTvshowDetail)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        WatchlistTvshowMessage(WatchListTvshowBloc.watchlistAddSuccessMessage),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistTvshows.execute(tTvshowDetail)),
    );

    blocTest<WatchListTvshowBloc, TvshowWatchlistState>(
      'should emit TvshowRemoveWatchlistError when data is gotten successfully',
      // arrange
      build: () {
        when(mockRemoveWatchlistTvshows.execute(tTvshowDetail))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvshowBloc;
      },

      // act
      act: (WatchListTvshowBloc bloc) =>
          bloc.add(RemoveWatchlistTvshow(tTvshowDetail)),
      // assert
      expect: () => <TvshowWatchlistState>[
        TvshowWatchlistLoading(),
        TvshowWatchlistHasError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockRemoveWatchlistTvshows.execute(tTvshowDetail)),
    );
  });
}
