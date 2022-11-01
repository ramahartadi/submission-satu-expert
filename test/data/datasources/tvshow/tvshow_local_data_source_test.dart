import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late TvshowLocalDataSourceImpl dataSourceTvshow;
  late MockDatabaseHelperTvshow mockDatabaseHelperTvshow;

  setUp(() {
    mockDatabaseHelperTvshow = MockDatabaseHelperTvshow();
    dataSourceTvshow = TvshowLocalDataSourceImpl(
        databaseHelperTvshow: mockDatabaseHelperTvshow);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTvshow.insertWatchlistTvshow(testTvshowTable))
          .thenAnswer((_) async => 1);
      // act
      final result =
          await dataSourceTvshow.insertWatchlistTvshow(testTvshowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTvshow.insertWatchlistTvshow(testTvshowTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTvshow.insertWatchlistTvshow(testTvshowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTvshow.removeWatchlistTvshow(testTvshowTable))
          .thenAnswer((_) async => 1);
      // act
      final result =
          await dataSourceTvshow.removeWatchlistTvshow(testTvshowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTvshow.removeWatchlistTvshow(testTvshowTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTvshow.removeWatchlistTvshow(testTvshowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tvshow Detail By Id', () {
    final tId = 1;

    test('should return Tvshow Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTvshow.getTvshowById(tId))
          .thenAnswer((_) async => testTvshowMap);
      // act
      final result = await dataSourceTvshow.getTvshowById(tId);
      // assert
      expect(result, testTvshowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTvshow.getTvshowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSourceTvshow.getTvshowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tvshows', () {
    test('should return list of TvshowTable from database', () async {
      // arrange
      when(mockDatabaseHelperTvshow.getWatchlistTvshows())
          .thenAnswer((_) async => [testTvshowMap]);
      // act
      final result = await dataSourceTvshow.getWatchlistTvshows();
      // assert
      expect(result, [testTvshowTable]);
    });
  });
}
