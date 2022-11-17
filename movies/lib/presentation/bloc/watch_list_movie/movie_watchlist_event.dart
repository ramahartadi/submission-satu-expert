part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWatchlistEvent extends MovieWatchlistEvent {}

class SaveWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  const SaveWatchlistMovie(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovie extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovie(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends MovieWatchlistEvent {
  final int id;

  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
