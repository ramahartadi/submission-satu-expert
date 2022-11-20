import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/bloc/list_movies/top_rated_movies_bloc.dart';

class TopRatedMoviesEventHelper extends Fake implements ListMoviesEvent {}

class TopRatedMoviesStateHelper extends Fake implements ListMoviesEvent {}

class TopRatedMoviesBlocHelper extends MockBloc<ListMoviesEvent, MoviesState>
    implements TopRatedMoviesBloc {}
