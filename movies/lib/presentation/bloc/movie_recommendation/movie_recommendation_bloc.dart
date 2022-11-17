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

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class RecommendationMovieBloc
    extends Bloc<MoviesRecommendationEvent, MoviesRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationMovieBloc(this.getMovieRecommendations)
      : super(MoviesRecommendationLoading()) {
    on<FetchMoviesRecommendationEvent>((event, emit) async {
      final int id = event.id;
      emit(MoviesRecommendationLoading());

      final result = await getMovieRecommendations.execute(id);
      result.fold((l) {
        emit(MoviesRecommendationHasError(l.message));
      }, (r) {
        emit(MoviesRecommendationHasData(r));
      });
    });
  }
}
