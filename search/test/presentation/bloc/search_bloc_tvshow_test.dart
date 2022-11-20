import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/usecases/search_tvshows.dart';
import 'package:search/presentation/bloc/search_bloc_tvshow.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_state.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import 'search_tvshow_bloc_test.mocks.dart';

@GenerateMocks([SearchTvshows])
void main() {
  late SearchBlocTvshow searchBloc;
  late MockSearchTvshows mockSearchTvshows;

  setUp(() {
    mockSearchTvshows = MockSearchTvshows();
    searchBloc = SearchBlocTvshow(mockSearchTvshows);
  });
  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
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
  const tQuery = 'spiderman';

  blocTest<SearchBlocTvshow, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvshowList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataTvshow(tTvshowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvshows.execute(tQuery));
    },
  );

  blocTest<SearchBlocTvshow, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvshows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvshows.execute(tQuery));
    },
  );
}
