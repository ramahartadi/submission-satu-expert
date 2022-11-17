part of 'tvshow_recommendation_bloc.dart';

abstract class TvshowsRecommendationState extends Equatable {
  const TvshowsRecommendationState();

  @override
  List<Object> get props => [];
}

class TvshowsRecommendationLoading extends TvshowsRecommendationState {}

class TvshowsRecommendationEmpty extends TvshowsRecommendationState {}

class TvshowsRecommendationHasError extends TvshowsRecommendationState {
  final String message;

  const TvshowsRecommendationHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvshowsRecommendationHasData extends TvshowsRecommendationState {
  final List<Tvshow> tvshow;

  const TvshowsRecommendationHasData(this.tvshow);

  @override
  List<Object> get props => [tvshow];
}
