import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'list_movies_event.dart';
import 'list_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<ListMoviesEvent, MoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MoviesEmpty()) {
    on<OnListMoviesCalled>(
      (event, emit) async {
        emit(MoviesLoading());
        final result = await _getTopRatedMovies.execute();

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
