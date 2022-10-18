import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:ditonton/presentation/provider/tvshow/top_rated_tvshows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvshows_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvshows])
void main() {
  late MockGetTopRatedTvshows mockGetTopRatedTvshows;
  late TopRatedTvshowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvshows = MockGetTopRatedTvshows();
    notifier =
        TopRatedTvshowsNotifier(getTopRatedTvshows: mockGetTopRatedTvshows)
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
    when(mockGetTopRatedTvshows.execute())
        .thenAnswer((_) async => Right(tTvshowList));
    // act
    notifier.fetchTopRatedTvshows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvshows data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTvshows.execute())
        .thenAnswer((_) async => Right(tTvshowList));
    // act
    await notifier.fetchTopRatedTvshows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvshows, tTvshowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvshows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvshows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
