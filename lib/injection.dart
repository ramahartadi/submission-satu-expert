import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/tvshow_database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:core/utils/sslpinning.dart';
import 'package:movies/presentation/bloc/list_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/top_rated_movies_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';
import 'package:search/presentation/bloc/search_bloc_tvshow.dart';
import 'package:search/search.dart';

import 'package:tvshows/domain/usecases/get_tvshow_detail.dart';
import 'package:tvshows/domain/usecases/get_tvshow_recommendations.dart';
import 'package:tvshows/domain/usecases/get_on_the_air_tvshows.dart';
import 'package:tvshows/domain/usecases/get_popular_tvshows.dart';
import 'package:tvshows/domain/usecases/get_top_rated_tvshows.dart';
import 'package:tvshows/domain/usecases/get_watchlist_tvshows.dart';
import 'package:tvshows/domain/usecases/get_watchlist_status_tvshows.dart';
import 'package:tvshows/domain/usecases/remove_watchlist_tvshow.dart';
import 'package:tvshows/domain/usecases/save_watchlist_tvshow.dart';
// import 'package:core/domain/usecases/tvshow/search_tvshows.dart';

import 'package:tvshows/presentation/provider/on_the_air_tvshows_notifier.dart';
import 'package:tvshows/presentation/provider/popular_tvshows_notifier.dart';
import 'package:tvshows/presentation/provider/top_rated_tvshows_notifier.dart';
import 'package:tvshows/presentation/provider/tvshow_detail_notifier.dart';
import 'package:tvshows/presentation/provider/tvshow_list_notifier.dart';
import 'package:tvshows/presentation/provider/tvshow_search_notifier.dart';
import 'package:tvshows/presentation/provider/watchlist_tvshow_notifier.dart';

import 'package:get_it/get_it.dart';

import 'package:tvshows/data/datasources/tvshow_local_data_source.dart';
import 'package:tvshows/data/datasources/tvshow_remote_data_source.dart';
import 'package:tvshows/data/repositories/tvshow_repository_impl.dart';
import 'package:tvshows/domain/repositories/tvshow_repository.dart';

import 'package:search/presentation/bloc/search_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
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
    () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
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
    () => SearchBlocTvshow(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvshowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvshowsNotifier(
      getTopRatedTvshows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchListMovieBloc(locator(), locator(), locator(), locator()),
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
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
