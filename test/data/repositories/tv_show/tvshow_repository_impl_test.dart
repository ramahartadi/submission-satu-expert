import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/data/repositories/tv_show/tvshow_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late TvshowRepositoryImpl repository;
  late MockTvshowRemoteDataSource mockRemoteDataSource;
  late MockTvshowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvshowRemoteDataSource();
    mockLocalDataSource = MockTvshowLocalDataSource();
    repository = TvshowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvshowModel = TvshowModel(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: [18, 9648],
    id: 31917,
    originalName: "Pretty Little Liars",
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    voteAverage: 5.04,
    voteCount: 133,
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    originCountry: ["US"],
    originalLanguage: "en",
  );

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

  final tTvshowModelList = <TvshowModel>[tTvshowModel];
  final tTvshowList = <Tvshow>[tTvshow];

  group('Now Playing Tvshows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvshows())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getOnTheAirTvshows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvshows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvshows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTvshows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvshows());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvshows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTvshows();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvshows());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tvshows', () {
    test('should return tvshow list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvshows())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getPopularTvshows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvshows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvshows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvshows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvshows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tvshows', () {
    test('should return tvshow list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvshows())
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.getTopRatedTvshows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvshows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvshows();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvshows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvshows();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tvshow Detail', () {
    final tId = 1;
    final tTvshowResponse = TvshowDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
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
      // nextEpisodeToAir: null,
      numberOfEpisodes: 73,
      numberOfSeasons: 8,
      originalLanguage: 'en',
      popularity: 369.594,
      status: 'Ended',
      tagline: 'Winter Is Coming',
      type: 'Scripted',
    );

    test(
        'should return Tvshow data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenAnswer((_) async => tTvshowResponse);
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result, equals(Right(testTvshowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tvshow Recommendations', () {
    final tTvshowList = <TvshowModel>[];
    final tId = 1;

    test('should return data (tvshow list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenAnswer((_) async => tTvshowList);
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvshowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvshowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvshowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvshowRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tvshows', () {
    final tQuery = 'spiderman';

    test('should return tvshow list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshow(tQuery))
          .thenAnswer((_) async => tTvshowModelList);
      // act
      final result = await repository.searchTvshow(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvshowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshow(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvshow(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvshow(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvshow(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvshow(testTvshowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvshow(testTvshowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvshow(testTvshowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvshow(testTvshowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvshow(testTvshowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTvshow(testTvshowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvshow(testTvshowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvshow(testTvshowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvshowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvshow(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tvshows', () {
    test('should return list of Tvshows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvshows())
          .thenAnswer((_) async => [testTvshowTable]);
      // act
      final result = await repository.getWatchlistTvshows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvshow]);
    });
  });
}
