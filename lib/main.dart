import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about.dart';
import 'package:movies/presentation/bloc/list_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:search/presentation/bloc/search_bloc_tvshow.dart';
import 'package:search/search.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/on_the_air_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/popular_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';
import 'package:tvshows/presentation/bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';
import 'package:tvshows/presentation/bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';
import 'package:tvshows/presentation/pages/home_tvshow_page.dart';
import 'package:tvshows/presentation/pages/on_the_air_tvshows_page.dart';
import 'package:tvshows/presentation/pages/popular_tvshows_page.dart';
import 'package:tvshows/presentation/pages/top_rated_tvshows_page.dart';
import 'package:tvshows/presentation/pages/tvshow_detail_page.dart';
import 'package:tvshows/presentation/pages/watchlist_tvshows_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;

import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:core/utils/sslpinning.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvshowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvshowDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBlocTvshow>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvshowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvshowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvshowsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchListTvshowBloc>(),
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
