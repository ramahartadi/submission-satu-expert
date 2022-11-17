import 'package:movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesHasData extends MoviesState {
  final List<Movie> result;

  const MoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
