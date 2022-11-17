import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:movies/presentation/bloc/watch_list_movie/movie_watchlist_bloc.dart';
import '../../presentation/provider/watchlist_movie_notifier.dart';
import '../../presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<WatchListMovieBloc>(context)
          .add(FetchMovieWatchlistEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchListMovieBloc>(context, listen: false)
        .add(FetchMovieWatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListMovieBloc, MovieWatchlistState>(
          builder: (context, state) {
            if (state is MovieWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movie[index];
                  return MovieCard(movie);
                },
                itemCount: state.movie.length,
              );
            } else if (state is MovieWatchlistHasError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Text('Wathlist Empty');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
