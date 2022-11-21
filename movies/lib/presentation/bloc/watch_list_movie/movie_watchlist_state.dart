part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistHasError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> movie;

  const MovieWatchlistHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieMessage extends MovieWatchlistState {
  final String message;

  const WatchlistMovieMessage(this.message);
}

class LoadWatchlistDataMovie extends MovieWatchlistState {
  final bool status;

  const LoadWatchlistDataMovie(this.status);

  @override
  List<Object> get props => [status];
}
