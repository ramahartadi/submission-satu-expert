import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/search_tvshows.dart';
import 'package:core/presentation/provider/tvshow/tvshow_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvshows])
void main() {
  late TvshowSearchNotifier provider;
  late MockSearchTvshows mockSearchTvshows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvshows = MockSearchTvshows();
    provider = TvshowSearchNotifier(searchTvshows: mockSearchTvshows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvshowModel = Tvshow(
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
  final tTvshowList = <Tvshow>[tTvshowModel];
  final tQuery = 'game of thrones';

  group('search tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvshowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
