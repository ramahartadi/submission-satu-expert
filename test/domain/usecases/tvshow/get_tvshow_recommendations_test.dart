import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetTvshowRecommendations usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetTvshowRecommendations(mockTvshowRepository);
  });

  final tId = 1;
  final tTvshows = <Tvshow>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockTvshowRepository.getTvshowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvshows));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvshows));
  });
}
