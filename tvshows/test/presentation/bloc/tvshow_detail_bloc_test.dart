import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvshows/domain/usecases/get_watchlist_status_tvshows.dart';
import 'package:tvshows/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:tvshows/domain/usecases/save_watchlist_tvshow.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tvshows/domain/usecases/get_tvshow_detail.dart';
import 'package:tvshows/domain/usecases/get_tvshow_recommendations.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';

import '../../../../test/dummy_data/dummy_objects_tvshow.dart';
import 'tvshow_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvshowDetail,
  GetTvshowRecommendations,
  GetWatchlistStatusTvshow,
  SaveWatchlistTvshow,
  RemoveWatchlistTvshow,
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
      verify: (bloc) => verify(mockGetTvshowDetail.execute(tId)),
    );
  });
}
