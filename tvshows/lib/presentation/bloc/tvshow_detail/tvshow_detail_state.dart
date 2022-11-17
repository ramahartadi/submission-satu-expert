part of 'tvshow_detail_bloc.dart';

abstract class TvshowDetailState extends Equatable {
  const TvshowDetailState();

  @override
  List<Object> get props => [];
}

class TvshowDetailLoading extends TvshowDetailState {}

class TvshowDetailEmpty extends TvshowDetailState {}

class TvshowDetailHasError extends TvshowDetailState {
  final String message;

  const TvshowDetailHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvshowDetailHasData extends TvshowDetailState {
  final TvshowDetail tvshow;

  const TvshowDetailHasData(this.tvshow);

  @override
  List<Object> get props => [tvshow];
}
