import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:search/search.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tvshow/home_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/on_the_air_tvshows_page.dart';
import 'package:core/presentation/pages/tvshow/popular_tvshows_page.dart';
import 'package:core/presentation/pages/tvshow/search_page_tvshow.dart';
import 'package:core/presentation/pages/tvshow/top_rated_tvshows_page.dart';
import 'package:core/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:core/presentation/pages/tvshow/watchlist_tvshows_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/tvshow/on_the_air_tvshows_notifier.dart';
import 'package:core/presentation/provider/tvshow/popular_tvshows_notifier.dart';
import 'package:core/presentation/provider/tvshow/top_rated_tvshows_notifier.dart';
import 'package:core/presentation/provider/tvshow/tvshow_detail_notifier.dart';
import 'package:core/presentation/provider/tvshow/tvshow_list_notifier.dart';
import 'package:core/presentation/provider/tvshow/tvshow_search_notifier.dart';
import 'package:core/presentation/provider/tvshow/watchlist_tvshow_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvshowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvshowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvshowSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvshowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvshowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvshowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvshowNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTvshowPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvshowPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case SearchPageTvshow.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTvshow());
            case WatchlistTvshowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvshowsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case OnTheAirTvshowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnTheAirTvshowsPage());
            case PopularTvshowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvshowsPage());
            case TopRatedTvshowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvshowsPage());
            case TvshowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvshowDetailPage(id: id),
                settings: settings,
              );

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
