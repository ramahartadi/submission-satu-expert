import 'package:equatable/equatable.dart';

abstract class ListMoviesEvent extends Equatable {}

class OnListMoviesCalled extends ListMoviesEvent {
  @override
  List<Object> get props => [];
}
