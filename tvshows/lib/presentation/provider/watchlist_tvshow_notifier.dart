import 'package:core/utils/state_enum.dart';
import '../../domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_watchlist_tvshows.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvshowNotifier extends ChangeNotifier {
  var _watchlistTvshows = <Tvshow>[];
  List<Tvshow> get watchlistTvshows => _watchlistTvshows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvshowNotifier({required this.getWatchlistTvshows});

  final GetWatchlistTv getWatchlistTvshows;

  Future<void> fetchWatchlistTvshows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvshows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvshows = tvshowsData;
        notifyListeners();
      },
    );
  }
}
