import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/tvshow_database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:search/search.dart';

import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/domain/usecases/tvshow/get_on_the_air_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshows.dart';
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/search_tvshows.dart';
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
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:core/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:core/data/datasources/tvshow/tvshow_remote_data_source.dart';
import 'package:core/data/repositories/tv_show/tvshow_repository_impl.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';

import 'package:search/presentation/bloc/search_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowListNotifier(
      getOnTheAirTvshows: locator(),
      getPopularTvshows: locator(),
      getTopRatedTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowDetailNotifier(
      getTvshowDetail: locator(),
      getTvshowRecommendations: locator(),
      getWatchListStatusTvshow: locator(),
      saveWatchlistTvshow: locator(),
      removeWatchlistTvshow: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvshowSearchNotifier(
      searchTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvshowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvshowsNotifier(
      getTopRatedTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvshowNotifier(
      getWatchlistTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvshowsNotifier(
      getOnTheAirTvshows: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTvshows(locator()));
  locator.registerLazySingleton(() => GetPopularTvshows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvshows(locator()));
  locator.registerLazySingleton(() => GetTvshowDetail(locator()));
  locator.registerLazySingleton(() => GetTvshowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvshows(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvshow(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvshow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvshow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvshows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvshowRepository>(
    () => TvshowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvshowRemoteDataSource>(
      () => TvshowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvshowLocalDataSource>(
      () => TvshowLocalDataSourceImpl(databaseHelperTvshow: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  locator.registerLazySingleton<DatabaseHelperTvshow>(
      () => DatabaseHelperTvshow());

  // external
  locator.registerLazySingleton(() => http.Client());
}
