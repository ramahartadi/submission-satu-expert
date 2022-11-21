part of 'tvshow_watchlist_bloc.dart';

abstract class TvshowWatchlistEvent extends Equatable {
  const TvshowWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvshowWatchlistEvent extends TvshowWatchlistEvent {}

class SaveWatchlistTvshowEvent extends TvshowWatchlistEvent {
  final TvshowDetail tvshow;

  const SaveWatchlistTvshowEvent(this.tvshow);
  @override
  List<Object> get props => [tvshow];
}

class RemoveWatchlistTvshowEvent extends TvshowWatchlistEvent {
  final TvshowDetail tvshow;

  const RemoveWatchlistTvshowEvent(this.tvshow);
  @override
  List<Object> get props => [tvshow];
}

class LoadWatchlistTvshowStatus extends TvshowWatchlistEvent {
  final int id;

  const LoadWatchlistTvshowStatus(this.id);

  @override
  List<Object> get props => [id];
}
