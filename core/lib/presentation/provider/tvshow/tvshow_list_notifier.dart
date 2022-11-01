import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/usecases/tvshow/get_on_the_air_tvshows.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/tvshow/get_popular_tvshows.dart';
import 'package:core/domain/usecases/tvshow/get_top_rated_tvshows.dart';
import 'package:flutter/material.dart';

class TvshowListNotifier extends ChangeNotifier {
  var _onTheAirTvshows = <Tvshow>[];
  List<Tvshow> get onTheAirTvshows => _onTheAirTvshows;

  RequestState _onTheAirTvshowsState = RequestState.Empty;
  RequestState get onTheAirTvshowsState => _onTheAirTvshowsState;

  var _popularTvshows = <Tvshow>[];
  List<Tvshow> get popularTvshows => _popularTvshows;

  RequestState _popularTvshowsState = RequestState.Empty;
  RequestState get popularTvshowsState => _popularTvshowsState;

  var _topRatedTvshows = <Tvshow>[];
  List<Tvshow> get topRatedTvshows => _topRatedTvshows;

  RequestState _topRatedTvshowsState = RequestState.Empty;
  RequestState get topRatedTvshowsState => _topRatedTvshowsState;

  String _message = '';
  String get message => _message;

  TvshowListNotifier({
    required this.getOnTheAirTvshows,
    required this.getPopularTvshows,
    required this.getTopRatedTvshows,
  });

  final GetOnTheAirTvshows getOnTheAirTvshows;
  final GetPopularTvshows getPopularTvshows;
  final GetTopRatedTvshows getTopRatedTvshows;

  Future<void> fetchOnTheAirTvshows() async {
    _onTheAirTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvshows.execute();
    result.fold(
      (failure) {
        _onTheAirTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowsData) {
        _onTheAirTvshowsState = RequestState.Loaded;
        _onTheAirTvshows = tvshowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvshows() async {
    _popularTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvshows.execute();
    result.fold(
      (failure) {
        _popularTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowsData) {
        _popularTvshowsState = RequestState.Loaded;
        _popularTvshows = tvshowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvshows() async {
    _topRatedTvshowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvshows.execute();
    result.fold(
      (failure) {
        _topRatedTvshowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshowsData) {
        _topRatedTvshowsState = RequestState.Loaded;
        _topRatedTvshows = tvshowsData;
        notifyListeners();
      },
    );
  }
}
