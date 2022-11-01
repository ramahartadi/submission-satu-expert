import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshows.dart';
import 'package:core/presentation/provider/tvshow/popular_tvshows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvshows_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvshows])
void main() {
  late MockGetPopularTvshows mockGetPopularTvshows;
  late PopularTvshowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvshows = MockGetPopularTvshows();
    notifier = PopularTvshowsNotifier(mockGetPopularTvshows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvshow = Tvshow(
    backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
    genreIds: [18, 9648],
    id: 31917,
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
    voteAverage: 5.04,
    voteCount: 133,
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'Pretty Little Liars',
  );

  final tTvshowList = <Tvshow>[tTvshow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvshows.execute())
        .thenAnswer((_) async => Right(tTvshowList));
    // act
    notifier.fetchPopularTvshows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvshows data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvshows.execute())
        .thenAnswer((_) async => Right(tTvshowList));
    // act
    await notifier.fetchPopularTvshows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvshows, tTvshowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvshows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvshows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
