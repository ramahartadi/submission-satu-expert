import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/on_the_air_tvshows_bloc.dart';
import 'package:tvshows/presentation/bloc/list_tvshows/top_rated_tvshows_bloc.dart';
import '../../domain/entities/tvshow.dart';
import 'package:core/utils/routes.dart';
import 'package:tvshows/presentation/pages/tvshow_detail_page.dart';
import 'package:tvshows/presentation/pages/popular_tvshows_page.dart';
// import '../../../../../search/lib/presentation/pages/search_page_tvshow.dart';
import 'package:tvshows/presentation/pages/top_rated_tvshows_page.dart';
import 'package:tvshows/presentation/pages/watchlist_tvshows_page.dart';
import 'package:tvshows/presentation/provider/tvshow_list_notifier.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../bloc/list_tvshows/list_tvshows_event.dart';
import '../bloc/list_tvshows/list_tvshows_state.dart';
import '../bloc/list_tvshows/popular_tvshows_bloc.dart';
import 'on_the_air_tvshows_page.dart';

class HomeTvshowPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tvshow';
  @override
  _HomeTvshowPageState createState() => _HomeTvshowPageState();
}

class _HomeTvshowPageState extends State<HomeTvshowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvshowsBloc>(context, listen: false)
          .add(OnListTvshowsCalled());
      BlocProvider.of<TopRatedTvshowsBloc>(context, listen: false)
          .add(OnListTvshowsCalled());
      BlocProvider.of<PopularTvshowsBloc>(context, listen: false)
          .add(OnListTvshowsCalled());
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
              title: Text('Tvshows'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.live_tv),
              title: Text('Tv Shows'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvshowsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.download_for_offline),
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
              Navigator.pushNamed(context, TVSHOW_SEARCH_ROUTE);
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
              _buildSubHeading(
                title: 'On The Air Tv Series',
                onTap: () => Navigator.pushNamed(
                    context, OnTheAirTvshowsPage.ROUTE_NAME),
              ),
              BlocBuilder<OnTheAirTvshowsBloc, TvshowsState>(
                builder: (context, state) {
                  if (state is TvshowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvshowsHasData) {
                    final data = state.result;
                    return TvshowList(data);
                  } else if (state is TvshowsError) {
                    return Text(state.message);
                  } else {
                    return const Center();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvshowsPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvshowsBloc, TvshowsState>(
                builder: (context, state) {
                  if (state is TvshowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvshowsHasData) {
                    final data = state.result;
                    return TvshowList(data);
                  } else if (state is TvshowsError) {
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
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvshowsPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvshowsBloc, TvshowsState>(
                builder: (context, state) {
                  if (state is TvshowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvshowsHasData) {
                    final data = state.result;
                    return TvshowList(data);
                  } else if (state is TvshowsError) {
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

class TvshowList extends StatelessWidget {
  final List<Tvshow> tvshows;

  TvshowList(this.tvshows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvshow = tvshows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvshowDetailPage.ROUTE_NAME,
                  arguments: tvshow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvshow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvshows.length,
      ),
    );
  }
}
