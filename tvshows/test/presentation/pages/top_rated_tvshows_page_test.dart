import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';
import 'package:tvshows/presentation/pages/top_rated_tvshows_page.dart';

import '../../dummy_data/dummy_objects_tvshow.dart';
import '../../helpers/test_helper_top_rated_tvshows_bloc.dart';

void main() {
  late TopRatedTvshowsBlocHelper topRatedTvshowsBlocHelper;

  setUpAll(() {
    topRatedTvshowsBlocHelper = TopRatedTvshowsBlocHelper();
    registerFallbackValue(TopRatedTvshowsBlocHelper());
    registerFallbackValue(TopRatedTvshowsStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvshowsBloc>(
      create: (_) => topRatedTvshowsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedTvshowsBlocHelper.state).thenReturn(TvshowsLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedTvshowsBlocHelper.state)
        .thenAnswer((invocation) => TvshowsLoading());
    when(() => topRatedTvshowsBlocHelper.state)
        .thenReturn(TvshowsHasData(testTvshowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedTvshowsBlocHelper.state)
        .thenReturn(TvshowsError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvshowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
