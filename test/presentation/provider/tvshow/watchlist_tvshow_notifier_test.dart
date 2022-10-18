import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvshow/get_watchlist_tvshows.dart';
import 'package:ditonton/presentation/provider/tvshow/watchlist_tvshow_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import 'watchlist_tvshow_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvshows])
void main() {
  late WatchlistTvshowNotifier provider;
  late MockGetWatchlistTvshows mockGetWatchlistTvshows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvshows = MockGetWatchlistTvshows();
    provider = WatchlistTvshowNotifier(
      getWatchlistTvshows: mockGetWatchlistTvshows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tvshows data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTvshows.execute())
        .thenAnswer((_) async => Right([testWatchlistTvshow]));
    // act
    await provider.fetchWatchlistTvshows();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTvshows, [testWatchlistTvshow]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvshows.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvshows();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
