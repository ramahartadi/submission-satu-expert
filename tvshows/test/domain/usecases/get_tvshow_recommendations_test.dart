import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_tvshow_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper_tvshow.mocks.dart';

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
