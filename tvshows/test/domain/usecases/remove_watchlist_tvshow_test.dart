import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects_tvshow.dart';
import '../../../../test/helpers/test_helper_tvshow.mocks.dart';

void main() {
  late RemoveWatchlistTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = RemoveWatchlistTvshow(mockTvshowRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvshowRepository.removeWatchlistTvshow(testTvshowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvshowDetail);
    // assert
    verify(mockTvshowRepository.removeWatchlistTvshow(testTvshowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
