import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import '../../presentation/provider/top_rated_movies_notifier.dart';
import '../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/list_movies/list_movies_state.dart';
import '../bloc/list_movies/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TopRatedMoviesBloc>(context).add(OnListMoviesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, MoviesState>(
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
