import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/bloc/list_movies/popular_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_popular_movies_bloc.dart';

void main() {
  late PopularMoviesBlocHelper popularMoviesBlocHelper;
  setUpAll(() {
    popularMoviesBlocHelper = PopularMoviesBlocHelper();
    registerFallbackValue(PopularMoviesStateHelper());
    registerFallbackValue(PopularMoviesEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => popularMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularMoviesBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
