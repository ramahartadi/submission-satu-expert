import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_popular_tvshows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetPopularTvshows usecase;
  late MockTvshowRepository mockTvshowRpository;

  setUp(() {
    mockTvshowRpository = MockTvshowRepository();
    usecase = GetPopularTvshows(mockTvshowRpository);
  });

  final tTvshows = <Tvshow>[];

  group('GetPopularTvshows Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvshowRpository.getPopularTvshows())
            .thenAnswer((_) async => Right(tTvshows));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvshows));
      });
    });
  });
}
