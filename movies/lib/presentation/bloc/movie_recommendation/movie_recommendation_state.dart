part of 'movie_recommendation_bloc.dart';

abstract class MoviesRecommendationState extends Equatable {
  const MoviesRecommendationState();

  @override
  List<Object> get props => [];
}

class MoviesRecommendationLoading extends MoviesRecommendationState {}

class MoviesRecommendationEmpty extends MoviesRecommendationState {}

class MoviesRecommendationHasError extends MoviesRecommendationState {
  final String message;

  const MoviesRecommendationHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesRecommendationHasData extends MoviesRecommendationState {
  final List<Movie> movie;

  const MoviesRecommendationHasData(this.movie);

  @override
  List<Object> get props => [movie];
}