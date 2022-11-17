part of 'tvshow_watchlist_bloc.dart';

abstract class TvshowWatchlistEvent extends Equatable {
  const TvshowWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvshowWatchlistEvent extends TvshowWatchlistEvent {}

class SaveWatchlistTvshow extends TvshowWatchlistEvent {
  final TvshowDetail tvshow;

  const SaveWatchlistTvshow(this.tvshow);
  @override
  List<Object> get props => [tvshow];
}

class RemoveWatchlistTvshow extends TvshowWatchlistEvent {
  final TvshowDetail tvshow;

  const RemoveWatchlistTvshow(this.tvshow);
  @override
  List<Object> get props => [tvshow];
}

class LoadWatchlistTvshowStatus extends TvshowWatchlistEvent {
  final int id;

  const LoadWatchlistTvshowStatus(this.id);

  @override
  List<Object> get props => [id];
}
