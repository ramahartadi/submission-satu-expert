import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/domain/usecases/get_popular_tvshows.dart';
import 'list_tvshows_event.dart';
import 'list_tvshows_state.dart';

class PopularTvshowsBloc extends Bloc<ListTvshowsEvent, TvshowsState> {
  final GetPopularTvshows _getPopularTvshows;

  PopularTvshowsBloc(this._getPopularTvshows) : super(TvshowsEmpty()) {
    on<OnListTvshowsCalled>(
      (event, emit) async {
        emit(TvshowsLoading());
        final result = await _getPopularTvshows.execute();

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
