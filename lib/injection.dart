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

import 'package:get_it/get_it.dart';

import 'package:tvshows/data/datasources/tvshow_local_data_source.dart';
import 'package:tvshows/data/datasources/tvshow_remote_data_source.dart';
import 'package:tvshows/data/repositories/tvshow_repository_impl.dart';
import 'package:tvshows/domain/repositories/tvshow_repository.dart';

import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/on_the_air_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/popular_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';
import 'package:tvshows/presentation/bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';
import 'package:tvshows/presentation/bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => OnTheAirTvshowsBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => TvshowDetailBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => RecommendationTvshowBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => SearchBlocTvshow(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => PopularTvshowsBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedTvshowsBloc(locator()));
  locator.registerFactory(
    () => WatchListMovieBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => WatchListTvshowBloc(locator(), locator(), locator(), locator()),
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
  locator.registerLazySingleton(() => GetWatchlistStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

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
