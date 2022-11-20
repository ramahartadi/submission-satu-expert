import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_event.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';

class TopRatedTvshowsEventHelper extends Fake implements ListTvshowsEvent {}

class TopRatedTvshowsStateHelper extends Fake implements ListTvshowsEvent {}

class TopRatedTvshowsBlocHelper extends MockBloc<ListTvshowsEvent, TvshowsState>
    implements TopRatedTvshowsBloc {}
