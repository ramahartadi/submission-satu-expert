import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshows.dart';
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:core/presentation/provider/tvshow/tvshow_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import 'tvshow_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvshowDetail,
  GetTvshowRecommendations,
  GetWatchListStatusTvshow,
  SaveWatchlistTvshow,
  RemoveWatchlistTvshow,
])
void main() {
  late TvshowDetailNotifier provider;
  late MockGetTvshowDetail mockGetTvshowDetail;
  late MockGetTvshowRecommendations mockGetTvshowRecommendations;
  late MockGetWatchListStatusTvshow mockGetWatchlistStatusTvshow;
  late MockSaveWatchlistTvshow mockSaveWatchlistTvshow;
  late MockRemoveWatchlistTvshow mockRemoveWatchlistTvshow;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvshowDetail = MockGetTvshowDetail();
    mockGetTvshowRecommendations = MockGetTvshowRecommendations();
    mockGetWatchlistStatusTvshow = MockGetWatchListStatusTvshow();
    mockSaveWatchlistTvshow = MockSaveWatchlistTvshow();
    mockRemoveWatchlistTvshow = MockRemoveWatchlistTvshow();
    provider = TvshowDetailNotifier(
      getTvshowDetail: mockGetTvshowDetail,
      getTvshowRecommendations: mockGetTvshowRecommendations,
      getWatchListStatusTvshow: mockGetWatchlistStatusTvshow,
      saveWatchlistTvshow: mockSaveWatchlistTvshow,
      removeWatchlistTvshow: mockRemoveWatchlistTvshow,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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
  final tTvshows = <Tvshow>[tTvshow];

  void _arrangeUsecase() {
    when(mockGetTvshowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvshowDetail));
    when(mockGetTvshowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvshows));
  }

  group('Get Tvshow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      verify(mockGetTvshowDetail.execute(tId));
      verify(mockGetTvshowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvshow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loaded);
      expect(provider.tvshow, testTvshowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tvshows when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Loaded);
      expect(provider.tvshowRecommendations, tTvshows);
    });
  });

  group('Get Tvshow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      verify(mockGetTvshowRecommendations.execute(tId));
      expect(provider.tvshowRecommendations, tTvshows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvshowRecommendations, tTvshows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvshowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvshowDetail));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTvshow.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      verify(mockSaveWatchlistTvshow.execute(testTvshowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvshowDetail);
      // assert
      verify(mockRemoveWatchlistTvshow.execute(testTvshowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      verify(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvshow.execute(testTvshowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusTvshow.execute(testTvshowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvshowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvshowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvshowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvshows));
      // act
      await provider.fetchTvshowDetail(tId);
      // assert
      expect(provider.tvshowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
