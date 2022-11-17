part of 'tvshow_recommendation_bloc.dart';

abstract class TvshowsRecommendationEvent extends Equatable {
  const TvshowsRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTvshowsRecommendationEvent extends TvshowsRecommendationEvent {
  final int id;

  const FetchTvshowsRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
