import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tvshow_detail.dart';
import '../../../domain/usecases/get_tvshow_detail.dart';
import '../../../domain/usecases/get_watchlist_status_tvshows.dart';
import '../../../domain/usecases/remove_watchlist_tvshow.dart';
import '../../../domain/usecases/save_watchlist_tvshow.dart';

part 'tvshow_detail_event.dart';
part 'tvshow_detail_state.dart';

class TvshowDetailBloc extends Bloc<TvshowDetailEvent, TvshowDetailState> {
  final GetTvshowDetail getTvshowDetail;

  TvshowDetailBloc(this.getTvshowDetail) : super(TvshowDetailLoading()) {
    on<FetchTvshowDetailEvent>((event, emit) async {
      final id = event.id;
      emit(TvshowDetailLoading());
      final result = await getTvshowDetail.execute(id);
      result.fold((failure) {
        emit(TvshowDetailHasError(failure.message));
      }, (data) {
        emit(TvshowDetailHasData(data));
      });
    });
  }
}
