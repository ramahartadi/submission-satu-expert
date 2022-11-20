import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_event.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/list_tvshows_state.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/popular_tvshows_bloc.dart';

class PopularTvshowsEventHelper extends Fake implements ListTvshowsEvent {}

class PopularTvshowsStateHelper extends Fake implements ListTvshowsEvent {}

class PopularTvshowsBlocHelper extends MockBloc<ListTvshowsEvent, TvshowsState>
    implements PopularTvshowsBloc {}
