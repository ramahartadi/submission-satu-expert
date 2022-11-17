import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_top_rated_tvshows.dart';
import 'list_tvshows_event.dart';
import 'list_tvshows_state.dart';

class TopRatedTvshowsBloc extends Bloc<ListTvshowsEvent, TvshowsState> {
  final GetTopRatedTvshows _getTopRatedTvshows;

  TopRatedTvshowsBloc(this._getTopRatedTvshows) : super(TvshowsEmpty()) {
    on<OnListTvshowsCalled>(
      (event, emit) async {
        emit(TvshowsLoading());
        final result = await _getTopRatedTvshows.execute();

        result.fold(
          (failure) {
            emit(TvshowsError(failure.message));
          },
          (data) {
            data.isNotEmpty ? emit(TvshowsHasData(data)) : emit(TvshowsEmpty());
          },
        );
      },
    );
  }
}
