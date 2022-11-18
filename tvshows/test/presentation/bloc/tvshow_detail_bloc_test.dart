import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_tvshow_detail.dart';
import 'package:tvshows/domain/usecases/get_tvshow_recommendations.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';

import '../../../../test/dummy_data/dummy_tvshow/dummy_objects_tvshow.dart';
import 'tvshow_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvshowDetail,
  GetTvshowRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvshowDetailBloc movieDetailBloc;
  late MockGetTvshowDetail mockGetTvshowDetail;
  late MockGetTvshowRecommendations mockGetTvshowRecommendations;

  setUp(() {
    mockGetTvshowDetail = MockGetTvshowDetail();
    mockGetTvshowRecommendations = MockGetTvshowRecommendations();
    movieDetailBloc = TvshowDetailBloc(
      mockGetTvshowDetail,
    );
  });

  final tId = 1;

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
  final tTvshows = <Tvshow>[tTvshow];

  void _arrangeUsecase() {
    when(mockGetTvshowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvshowDetail));
    when(mockGetTvshowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvshows));
  }

  group('Get Tvshow Detail', () {
    blocTest<TvshowDetailBloc, TvshowDetailState>(
        'should emits TvshowDetailHasData state when fetch data is success',
        build: () {
          when(mockGetTvshowDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvshowDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(FetchTvshowDetailEvent(tId)),
        expect: () => <TvshowDetailState>[
              TvshowDetailLoading(),
              TvshowDetailHasData(testTvshowDetail),
            ],
        verify: (bloc) {
          verify(mockGetTvshowDetail.execute(tId));
          return FetchTvshowDetailEvent(tId).props;
        });

    blocTest<TvshowDetailBloc, TvshowDetailState>(
      'should emits TvshowDetailError when data is failed',
      build: () {
        when(mockGetTvshowDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvshowDetailEvent(tId)),
      expect: () => <TvshowDetailState>[
        TvshowDetailLoading(),
        TvshowDetailHasError('Server Failure'),
      ],
      verify: (bloc) => TvshowDetailLoading(),
    );
  });
}
