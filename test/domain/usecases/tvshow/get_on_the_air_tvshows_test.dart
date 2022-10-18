import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_on_the_air_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetOnTheAirTvshows usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetOnTheAirTvshows(mockTvshowRepository);
  });

  final tTvshows = <Tvshow>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvshowRepository.getOnTheAirTvshows())
        .thenAnswer((_) async => Right(tTvshows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvshows));
  });
}
