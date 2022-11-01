import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_on_the_air_tvshows.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:core/presentation/provider/tvshow/tvshow_list_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvshow_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvshows, GetPopularTvshows, GetTopRatedTvshows])
void main() {
  late TvshowListNotifier provider;
  late MockGetOnTheAirTvshows mockGetOnTheAirTvshows;
  late MockGetPopularTvshows mockGetPopularTvshows;
  late MockGetTopRatedTvshows mockGetTopRatedTvshows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvshows = MockGetOnTheAirTvshows();
    mockGetPopularTvshows = MockGetPopularTvshows();
    mockGetTopRatedTvshows = MockGetTopRatedTvshows();
    provider = TvshowListNotifier(
      getOnTheAirTvshows: mockGetOnTheAirTvshows,
      getPopularTvshows: mockGetPopularTvshows,
      getTopRatedTvshows: mockGetTopRatedTvshows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvshow = Tvshow(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: [18, 9648],
    id: 31917,
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    voteAverage: 5.04,
    voteCount: 133,
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'Pretty Little Liars',
  );
  final tTvshowList = <Tvshow>[tTvshow];

  group('now playing tvshows', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTvshowsState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOnTheAirTvshows();
      // assert
      verify(mockGetOnTheAirTvshows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchOnTheAirTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loading);
    });

    test('should change tvshows when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchOnTheAirTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Loaded);
      expect(provider.onTheAirTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTvshows();
      // assert
      expect(provider.onTheAirTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvshows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Loaded);
      expect(provider.popularTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvshows();
      // assert
      expect(provider.popularTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvshows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Loading);
    });

    test('should change tvshows data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      // act
      await provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Loaded);
      expect(provider.topRatedTvshows, tTvshowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvshows();
      // assert
      expect(provider.topRatedTvshowsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
