part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailHasError extends MovieDetailState {
  final String message;

  const MovieDetailHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movie;

  const MovieDetailHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
