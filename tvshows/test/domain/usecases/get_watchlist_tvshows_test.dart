import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/usecases/get_watchlist_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_objects_tvshow.dart';
import '../../../../test/helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetWatchlistTv(mockTvshowRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvshowRepository.getWatchlistTvshows())
        .thenAnswer((_) async => Right(testTvshowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvshowList));
  });
}
