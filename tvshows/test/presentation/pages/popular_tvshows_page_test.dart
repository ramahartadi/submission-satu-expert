import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/pages/popular_tvshows_page.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/popular_tvshows_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects_tvshow.dart';
import '../../helpers/test_helper_popular_tvshows_bloc.dart';

void main() {
  late PopularTvshowsBlocHelper popularTvshowsBlocHelper;
  setUpAll(() {
    popularTvshowsBlocHelper = PopularTvshowsBlocHelper();
    registerFallbackValue(PopularTvshowsStateHelper());
    registerFallbackValue(PopularTvshowsEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvshowsBloc>(
      create: (_) => popularTvshowsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvshowsBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvshowsBlocHelper.state).thenReturn(TvshowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvshowsBlocHelper.state).thenReturn(TvshowsLoading());
    when(() => popularTvshowsBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularTvshowsBlocHelper.state)
        .thenReturn(TvshowsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvshowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
