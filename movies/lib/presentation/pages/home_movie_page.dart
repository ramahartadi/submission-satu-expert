import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:movies/presentation/bloc/list_movies/list_movies_event.dart';
import 'package:movies/presentation/bloc/list_movies/now_playing_movies_bloc.dart';
import '../../domain/entities/movie.dart';
import 'package:core/utils/routes.dart';
import '../../presentation/pages/movie_detail_page.dart';
import '../../presentation/pages/popular_movies_page.dart';
import '../../presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tvshow/home_tvshow_page.dart';
import 'package:core/presentation/pages/tvshow/watchlist_tvshows_page.dart';
import '../../presentation/pages/watchlist_movies_page.dart';
// import '../../presentation/provider/movie_list_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list_movies/list_movies_state.dart';
import '../bloc/list_movies/popular_movies_bloc.dart';
import '../bloc/list_movies/top_rated_movies_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(OnListMoviesCalled());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(OnListMoviesCalled());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(OnListMoviesCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv),
              title: Text('Tv Shows'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvshowPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.download_for_offline_outlined),
              title: Text('Watchlist Tvshow'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvshowsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesHasData) {
                    final data = state.result;
                    return MovieList(data);
                  } else if (state is MoviesError) {
                    return Text(state.message);
                  } else {
                    return const Center();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesHasData) {
                    final data = state.result;
                    return MovieList(data);
                  } else if (state is MoviesError) {
                    return Text(state.message);
                  } else {
                    return Center(
                      child: Text('Empty'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesHasData) {
                    final data = state.result;
                    return MovieList(data);
                  } else if (state is MoviesError) {
                    return Text(state.message);
                  } else {
                    return Center(
                      child: Text('Empty'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
