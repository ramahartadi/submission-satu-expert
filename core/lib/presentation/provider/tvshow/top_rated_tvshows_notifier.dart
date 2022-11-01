import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvshowsNotifier extends ChangeNotifier {
  final GetTopRatedTvshows getTopRatedTvshows;

  TopRatedTvshowsNotifier({required this.getTopRatedTvshows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvshow> _tvshows = [];
  List<Tvshow> get tvshows => _tvshows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvshows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvshows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvshowsData) {
        _tvshows = tvshowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
