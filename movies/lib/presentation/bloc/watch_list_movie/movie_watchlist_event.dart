part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWatchlistEvent extends MovieWatchlistEvent {}

class SaveWatchlistMovieEvent extends MovieWatchlistEvent {
  final MovieDetail movie;

  const SaveWatchlistMovieEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovieEvent extends MovieWatchlistEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovieEvent(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatusEvent extends MovieWatchlistEvent {
  final int id;

  const LoadWatchlistMovieStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}
