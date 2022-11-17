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
  final GetWatchlistMovies getWatchlistMovie;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchListMovieBloc(this.getWatchlistMovie, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(MovieWatchlistEmpty()) {
    on<FetchMovieWatchlistEvent>(
      (event, emit) async {
        emit(MovieWatchlistLoading());

        final result = await getWatchlistMovie.execute();
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
      final result = await saveWatchlist.execute(movie);

      result.fold((l) => emit(MovieWatchlistHasError(l.message)),
          (r) => emit(WatchlistMovieMessage(r)));
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movie;
      emit(MovieWatchlistLoading());
      final result = await removeWatchlist.execute(movie);

      result.fold((l) => emit(MovieWatchlistHasError(l.message)),
          (r) => emit(WatchlistMovieMessage(r)));
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieWatchlistLoading());
      final result = await getWatchListStatus.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
