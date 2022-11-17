part of 'tvshow_detail_bloc.dart';

abstract class TvshowDetailEvent extends Equatable {
  const TvshowDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvshowDetailEvent extends TvshowDetailEvent {
  final int id;

  FetchTvshowDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
