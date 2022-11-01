import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetWatchListStatusTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetWatchListStatusTvshow(mockTvshowRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvshowRepository.isAddedToWatchlistTvshow(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
