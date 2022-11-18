import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_top_rated_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/helpers/test_helper_tvshow.mocks.dart';

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
