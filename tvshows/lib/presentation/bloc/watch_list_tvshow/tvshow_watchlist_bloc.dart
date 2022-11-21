import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/domain/usecases/get_watchlist_status_tvshows.dart';
import 'package:tvshows/domain/usecases/save_watchlist_tvshow.dart';
import 'package:tvshows/domain/usecases/remove_watchlist_tvshow.dart';

import '../../../domain/entities/tvshow.dart';
import '../../../domain/entities/tvshow_detail.dart';
import '../../../domain/usecases/get_watchlist_tvshows.dart';

part 'tvshow_watchlist_event.dart';
part 'tvshow_watchlist_state.dart';

class WatchlistTvshowBloc
    extends Bloc<TvshowWatchlistEvent, TvshowWatchlistState> {
  final GetWatchlistTvshow getWatchlistTvshow;
  final GetWatchlistStatusTvshow getWatchlistStatusTvshow;
  final SaveWatchlistTvshow saveWatchlistTvshow;
  final RemoveWatchlistTvshow removeWatchlistTvshow;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvshowBloc(this.getWatchlistTvshow, this.getWatchlistStatusTvshow,
      this.saveWatchlistTvshow, this.removeWatchlistTvshow)
      : super(TvshowWatchlistEmpty()) {
    on<FetchTvshowWatchlistEvent>(
      (event, emit) async {
        emit(TvshowWatchlistLoading());

        final result = await getWatchlistTvshow.execute();
        result.fold((l) {
          emit(TvshowWatchlistHasError(l.message));
        }, (r) {
          emit(TvshowWatchlistHasData(r));
        });
      },
    );

    on<SaveWatchlistTvshowEvent>((event, emit) async {
      final tvshow = event.tvshow;
      emit(TvshowWatchlistLoading());
      final result = await saveWatchlistTvshow.execute(tvshow);

      result.fold((l) => emit(TvshowWatchlistHasError(l.message)),
          (r) => emit(WatchlistTvshowMessage(r)));
    });

    on<RemoveWatchlistTvshowEvent>((event, emit) async {
      final tvshow = event.tvshow;
      emit(TvshowWatchlistLoading());
      final result = await removeWatchlistTvshow.execute(tvshow);

      result.fold((l) => emit(TvshowWatchlistHasError(l.message)),
          (r) => emit(WatchlistTvshowMessage(r)));
    });

    on<LoadWatchlistTvshowStatus>((event, emit) async {
      final id = event.id;
      emit(TvshowWatchlistLoading());
      final result = await getWatchlistStatusTvshow.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
