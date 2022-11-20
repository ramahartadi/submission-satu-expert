import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_state.dart';
import 'package:movies/presentation/bloc/list_movies/popular_movies_bloc.dart';

class PopularMoviesEventHelper extends Fake implements ListMoviesEvent {}

class PopularMoviesStateHelper extends Fake implements ListMoviesEvent {}

class PopularMoviesBlocHelper extends MockBloc<ListMoviesEvent, MoviesState>
    implements PopularMoviesBloc {}
