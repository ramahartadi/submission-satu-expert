import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
// import 'package:core/domain/usecases/tvshow/search_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvshows.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late SearchTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = SearchTvshows(mockTvshowRepository);
  });

  final tTvshows = <Tvshow>[];
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvshowRepository.searchTvshow(tQuery))
        .thenAnswer((_) async => Right(tTvshows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvshows));
  });
}
