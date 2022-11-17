import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvshow.dart';

abstract class TvshowsState extends Equatable {
  const TvshowsState();

  @override
  List<Object> get props => [];
}

class TvshowsEmpty extends TvshowsState {}

class TvshowsLoading extends TvshowsState {}

class TvshowsError extends TvshowsState {
  final String message;

  const TvshowsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvshowsHasData extends TvshowsState {
  final List<Tvshow> result;

  const TvshowsHasData(this.result);

  @override
  List<Object> get props => [result];
}
