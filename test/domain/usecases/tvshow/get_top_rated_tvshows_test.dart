import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetTopRatedTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetTopRatedTvshows(mockTvshowRepository);
  });

  final tTvshows = <Tvshow>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTvshowRepository.getTopRatedTvshows())
        .thenAnswer((_) async => Right(tTvshows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvshows));
  });
}
