import 'package:core/utils/state_enum.dart';
import '../../domain/entities/tvshow.dart';
import 'package:tvshows/domain/usecases/get_on_the_air_tvshows.dart';
import 'package:flutter/foundation.dart';

class OnTheAirTvshowsNotifier extends ChangeNotifier {
  final GetOnTheAirTvshows getOnTheAirTvshows;

  OnTheAirTvshowsNotifier({required this.getOnTheAirTvshows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvshow> _tvshows = [];
  List<Tvshow> get tvshows => _tvshows;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTvshows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvshows.execute();

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
