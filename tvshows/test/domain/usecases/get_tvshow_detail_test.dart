import 'package:dartz/dartz.dart';
import 'package:tvshows/domain/usecases/get_tvshow_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test/dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import '../../../../test/helpers/test_helper_tvshow.mocks.dart';

void main() {
  late GetTvshowDetail usecase;
  late MockTvshowRepository mockTvshowRepository;

  setUp(() {
    mockTvshowRepository = MockTvshowRepository();
    usecase = GetTvshowDetail(mockTvshowRepository);
  });

  final tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockTvshowRepository.getTvshowDetail(tId))
        .thenAnswer((_) async => Right(testTvshowDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvshowDetail));
  });
}
