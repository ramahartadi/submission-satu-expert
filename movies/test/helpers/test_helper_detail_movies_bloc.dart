import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';

class MovieDetailEventHelper extends Fake implements MovieDetailEvent {}

class MovieDetailStateHelper extends Fake implements MovieDetailState {}

class MovieDetailBlocHelper extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class RecommendationsMovieEventHelper extends Fake
    implements MoviesRecommendationEvent {}

class RecommendationsMovieStateHelper extends Fake
    implements MoviesRecommendationState {}

class RecommendationsMovieBlocHelper
    extends MockBloc<MoviesRecommendationEvent, MoviesRecommendationState>
    implements RecommendationMovieBloc {}

class WatchlistMovieEventHelper extends Fake
    implements FetchMovieWatchlistEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieWatchlistState {}

class WatchlistMovieBlocHelper
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements WatchListMovieBloc {}
