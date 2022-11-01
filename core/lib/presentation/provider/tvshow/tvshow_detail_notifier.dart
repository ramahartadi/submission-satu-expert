import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_detail.dart';
import 'package:core/domain/usecases/tvshow/get_tvshow_recommendations.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/tvshow/get_watchlist_status_tvshows.dart';
import 'package:core/domain/usecases/tvshow/remove_watchlist_tvshow.dart';
import 'package:core/domain/usecases/tvshow/save_watchlist_tvshow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvshowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvshowDetail getTvshowDetail;
  final GetTvshowRecommendations getTvshowRecommendations;
  final GetWatchListStatusTvshow getWatchListStatusTvshow;
  final SaveWatchlistTvshow saveWatchlistTvshow;
  final RemoveWatchlistTvshow removeWatchlistTvshow;

  TvshowDetailNotifier({
    required this.getTvshowDetail,
    required this.getTvshowRecommendations,
    required this.getWatchListStatusTvshow,
    required this.saveWatchlistTvshow,
    required this.removeWatchlistTvshow,
  });

  late TvshowDetail _tvshow;
  TvshowDetail get tvshow => _tvshow;

  RequestState _tvshowState = RequestState.Empty;
  RequestState get tvshowState => _tvshowState;

  List<Tvshow> _tvshowRecommendations = [];
  List<Tvshow> get tvshowRecommendations => _tvshowRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvshowDetail(int id) async {
    _tvshowState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvshowDetail.execute(id);
    final recommendationResult = await getTvshowRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvshowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvshow) {
        _recommendationState = RequestState.Loading;
        _tvshow = tvshow;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvshows) {
            _recommendationState = RequestState.Loaded;
            _tvshowRecommendations = tvshows;
          },
        );
        _tvshowState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvshowDetail tvshow) async {
    final result = await saveWatchlistTvshow.execute(tvshow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvshow.id);
  }

  Future<void> removeFromWatchlist(TvshowDetail tvshow) async {
    final result = await removeWatchlistTvshow.execute(tvshow);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvshow.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTvshow.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
