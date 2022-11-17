import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'list_movies_event.dart';
import 'list_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<ListMoviesEvent, MoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MoviesEmpty()) {
    on<OnListMoviesCalled>(
      (event, emit) async {
        emit(MoviesLoading());
        final result = await _getNowPlayingMovies.execute();

        result.fold(
          (failure) {
            emit(MoviesError(failure.message));
          },
          (data) {
            data.isNotEmpty ? emit(MoviesHasData(data)) : emit(MoviesEmpty());
          },
        );
      },
    );
  }
}
