import 'package:search/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import 'search_state.dart';
import 'search_event.dart';

class SearchBlocTvshow extends Bloc<SearchEvent, SearchState> {
  final SearchTvshows _searchTvshows;

  SearchBlocTvshow(this._searchTvshows) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTvshows.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasDataTvshow(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
