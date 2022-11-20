import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshows/presentation/bloc/tvshow_detail/tvshow_detail_bloc.dart';
import 'package:tvshows/presentation/bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';
import 'package:tvshows/presentation/bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';

class TvshowDetailEventHelper extends Fake implements TvshowDetailEvent {}

class TvshowDetailStateHelper extends Fake implements TvshowDetailState {}

class TvshowDetailBlocHelper
    extends MockBloc<TvshowDetailEvent, TvshowDetailState>
    implements TvshowDetailBloc {}

class RecommendationsTvshowEventHelper extends Fake
    implements TvshowsRecommendationEvent {}

class RecommendationsTvshowStateHelper extends Fake
    implements TvshowsRecommendationState {}

class RecommendationsTvshowBlocHelper
    extends MockBloc<TvshowsRecommendationEvent, TvshowsRecommendationState>
    implements RecommendationTvshowBloc {}

class WatchlistTvshowEventHelper extends Fake
    implements FetchTvshowWatchlistEvent {}

class WatchlistTvshowStateHelper extends Fake implements TvshowWatchlistState {}

class WatchlistTvshowBlocHelper
    extends MockBloc<TvshowWatchlistEvent, TvshowWatchlistState>
    implements WatchListTvshowBloc {}
