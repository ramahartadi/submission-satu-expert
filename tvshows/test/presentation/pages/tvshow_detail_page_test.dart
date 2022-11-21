import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';
import 'package:tvshows/presentation/bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';
import 'package:tvshows/presentation/pages/tvshow_detail_page.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects_tvshow.dart';
import '../../helpers/test_helper_detail_tvshows_bloc.dart';
import '../../helpers/test_helper_popular_tvshows_bloc.dart';

void main() {
  late TvshowDetailBlocHelper tvshowDetailBlocHelper;
  late RecommendationsTvshowBlocHelper recommendationsTvshowBlocHelper;
  late WatchlistTvshowBlocHelper watchlistTvshowBlocHelper;

  setUpAll(() {
    tvshowDetailBlocHelper = TvshowDetailBlocHelper();
    registerFallbackValue(TvshowDetailEventHelper());
    registerFallbackValue(TvshowDetailStateHelper());

    recommendationsTvshowBlocHelper = RecommendationsTvshowBlocHelper();
    registerFallbackValue(RecommendationsTvshowEventHelper());
    registerFallbackValue(RecommendationsTvshowStateHelper());

    watchlistTvshowBlocHelper = WatchlistTvshowBlocHelper();
    registerFallbackValue(WatchlistTvshowEventHelper());
    registerFallbackValue(WatchlistTvshowStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvshowDetailBloc>(create: (_) => tvshowDetailBlocHelper),
        BlocProvider<WatchlistTvshowBloc>(
          create: (_) => watchlistTvshowBlocHelper,
        ),
        BlocProvider<RecommendationTvshowBloc>(
          create: (_) => recommendationsTvshowBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state).thenReturn(TvshowDetailLoading());
    when(() => watchlistTvshowBlocHelper.state)
        .thenReturn(TvshowWatchlistLoading());
    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowsRecommendationLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when tvshow not added to watch list',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state)
        .thenReturn(TvshowDetailHasData(testTvshowDetail));
    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowsRecommendationHasData(testTvshowList));
    when(() => watchlistTvshowBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tvshow added to watch list',
      (WidgetTester tester) async {
    when(() => tvshowDetailBlocHelper.state)
        .thenReturn(TvshowDetailHasData(testTvshowDetail));

    when(() => recommendationsTvshowBlocHelper.state)
        .thenReturn(TvshowsRecommendationHasData(testTvshowList));
    when(() => watchlistTvshowBlocHelper.state)
        .thenReturn(LoadWatchlistData(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvshowDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
