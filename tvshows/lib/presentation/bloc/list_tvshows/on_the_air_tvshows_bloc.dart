import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/domain/usecases/get_on_the_air_tvshows.dart';
import 'list_tvshows_event.dart';
import 'list_tvshows_state.dart';

class OnTheAirTvshowsBloc extends Bloc<ListTvshowsEvent, TvshowsState> {
  final GetOnTheAirTvshows _getOnTheAirTvshows;

  OnTheAirTvshowsBloc(this._getOnTheAirTvshows) : super(TvshowsEmpty()) {
    on<OnListTvshowsCalled>(
      (event, emit) async {
        emit(TvshowsLoading());
        final result = await _getOnTheAirTvshows.execute();

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
