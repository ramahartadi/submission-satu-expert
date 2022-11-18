import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_top_rated_tvshows.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_event.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';

import 'top_rated_tvshows_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvshows])
void main() {
  late MockGetTopRatedTvshows mockGetTopRatedTvshows;
  late TopRatedTvshowsBloc popularTvshowsBloc;
  late int listenerCallCount;

  setUp(() {
    mockGetTopRatedTvshows = MockGetTopRatedTvshows();
    popularTvshowsBloc = TopRatedTvshowsBloc(mockGetTopRatedTvshows);
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

  blocTest<TopRatedTvshowsBloc, TvshowsState>(
    'should emit TopRatedTvshowHasData when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Right(tTvshowList));
      return popularTvshowsBloc;
    },

    // act
    act: (bloc) => bloc.add(OnListTvshowsCalled()),
    // assert
    expect: () => <TvshowsState>[
      TvshowsLoading(),
      TvshowsHasData(tTvshowList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTvshows.execute()),
  );

  blocTest<TopRatedTvshowsBloc, TvshowsState>(
    'should emits error when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvshowsBloc;
    },
    act: (bloc) => bloc.add(OnListTvshowsCalled()),
    expect: () => <TvshowsState>[
      TvshowsLoading(),
      TvshowsError('Server Failure'),
    ],
    verify: (bloc) => TvshowsLoading(),
  );

  blocTest<TopRatedTvshowsBloc, TvshowsState>(
    'should emits TopRatedTvshowsEmpty state when data is empty',
    build: () {
      when(mockGetTopRatedTvshows.execute())
          .thenAnswer((_) async => const Right([]));
      return popularTvshowsBloc;
    },
    act: (bloc) => bloc.add(OnListTvshowsCalled()),
    expect: () => <TvshowsState>[
      TvshowsLoading(),
      TvshowsEmpty(),
    ],
  );
}
