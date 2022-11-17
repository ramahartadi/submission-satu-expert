import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailLoading()) {
    on<FetchMovieDetailEvent>((event, emit) async {
      final id = event.id;
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MovieDetailHasError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}
