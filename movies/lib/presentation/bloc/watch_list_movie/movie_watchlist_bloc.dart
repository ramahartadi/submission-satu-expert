import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class WatchListMovieBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovie;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchListMovieBloc(this._getWatchlistMovie, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MovieWatchlistEmpty()) {
    on<FetchMovieWatchlistEvent>(
      (event, emit) async {
        emit(MovieWatchlistLoading());

        final result = await _getWatchlistMovie.execute();
        result.fold((l) {
          emit(MovieWatchlistHasError(l.message));
        }, (r) {
          emit(MovieWatchlistHasData(r));
        });
      },
    );

    on<SaveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MovieWatchlistLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold((failure) => emit(MovieWatchlistHasError(failure.message)),
          (message) => emit(WatchlistMovieMessage(message)));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MovieWatchlistLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold((failure) => emit(MovieWatchlistHasError(failure.message)),
          (message) => emit(WatchlistMovieMessage(message)));
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieWatchlistLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
