import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/usecases/tvshow/get_popular_tvshows.dart';
import 'package:flutter/foundation.dart';

class PopularTvshowsNotifier extends ChangeNotifier {
  final GetPopularTvshows getPopularTvshows;

  PopularTvshowsNotifier(this.getPopularTvshows);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvshow> _tvshows = [];
  List<Tvshow> get tvshows => _tvshows;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvshows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvshows.execute();

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
