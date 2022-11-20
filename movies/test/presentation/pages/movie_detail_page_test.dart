import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_detail_movies_bloc.dart';
import '../../helpers/test_helper_popular_movies_bloc.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsMovieBlocHelper recommendationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    recommendationsMovieBlocHelper = RecommendationsMovieBlocHelper();
    registerFallbackValue(RecommendationsMovieEventHelper());
    registerFallbackValue(RecommendationsMovieStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchListMovieBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => recommendationsMovieBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state).thenReturn(MovieDetailLoading());
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(MovieWatchlistLoading());
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesRecommendationLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));

    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesRecommendationHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
