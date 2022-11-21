import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/usecases/save_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tvshow.dart';
import '../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late SaveWatchlistTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = SaveWatchlistTvshow(mockTvshowRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTvshowRepository.saveWatchlistTvshow(testTvshowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvshowDetail);
    // assert
    verify(mockTvshowRepository.saveWatchlistTvshow(testTvshowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
