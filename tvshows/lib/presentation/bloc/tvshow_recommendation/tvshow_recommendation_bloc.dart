import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tvshow.dart';
import '../../../domain/usecases/get_tvshow_recommendations.dart';

part 'tvshow_recommendation_event.dart';
part 'tvshow_recommendation_state.dart';

class RecommendationTvshowBloc
    extends Bloc<TvshowsRecommendationEvent, TvshowsRecommendationState> {
  final GetTvshowRecommendations getTvshowRecommendations;
  RecommendationTvshowBloc(this.getTvshowRecommendations)
      : super(TvshowsRecommendationLoading()) {
    on<FetchTvshowsRecommendationEvent>((event, emit) async {
      final int id = event.id;
      emit(TvshowsRecommendationLoading());

      final result = await getTvshowRecommendations.execute(id);
      result.fold((l) {
        emit(TvshowsRecommendationHasError(l.message));
      }, (r) {
        emit(TvshowsRecommendationHasData(r));
      });
    });
  }
}
