import 'package:tvshows/domain/usecases/get_watchlist_status_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetWatchlistStatusTvshow usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetWatchlistStatusTvshow(mockTvshowRepository);
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
