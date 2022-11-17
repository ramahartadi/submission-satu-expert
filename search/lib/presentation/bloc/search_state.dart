import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SearchHasDataTvshow extends SearchState {
  final List<Tvshow> resultTvshow;

  SearchHasDataTvshow(this.resultTvshow);

  @override
  List<Object> get props => [resultTvshow];
}
