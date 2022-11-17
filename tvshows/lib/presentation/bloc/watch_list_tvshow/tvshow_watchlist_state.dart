part of 'tvshow_watchlist_bloc.dart';

abstract class TvshowWatchlistState extends Equatable {
  const TvshowWatchlistState();

  @override
  List<Object> get props => [];
}

class TvshowWatchlistLoading extends TvshowWatchlistState {}

class TvshowWatchlistEmpty extends TvshowWatchlistState {}

class TvshowWatchlistHasError extends TvshowWatchlistState {
  final String message;

  const TvshowWatchlistHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvshowWatchlistHasData extends TvshowWatchlistState {
  final List<Tvshow> tvshow;

  const TvshowWatchlistHasData(this.tvshow);

  @override
  List<Object> get props => [tvshow];
}

class WatchlistTvshowMessage extends TvshowWatchlistState {
  final String message;

  const WatchlistTvshowMessage(this.message);
}

class LoadWatchlistData extends TvshowWatchlistState {
  final bool status;

  const LoadWatchlistData(this.status);

  @override
  List<Object> get props => [status];
}
