import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'list_movies_event.dart';
import 'list_movies_state.dart';

class PopularMoviesBloc extends Bloc<ListMoviesEvent, MoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MoviesEmpty()) {
    on<OnListMoviesCalled>(
      (event, emit) async {
        emit(MoviesLoading());
        final result = await _getPopularMovies.execute();

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
