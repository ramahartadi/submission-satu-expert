part of 'movie_recommendation_bloc.dart';

abstract class MoviesRecommendationEvent extends Equatable {
  const MoviesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesRecommendationEvent extends MoviesRecommendationEvent {
  final int id;

  const FetchMoviesRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
