import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/popular_movies_bloc.dart';
// import '../../presentation/provider/popular_movies_notifier.dart';
import '../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/list_movies/list_movies_state.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PopularMoviesBloc>(context).add(OnListMoviesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(movie);
                },
                itemCount: movies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as MoviesError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
