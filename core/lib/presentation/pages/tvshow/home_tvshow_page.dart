import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:core/presentation/pages/tvshow/popular_tvshows_page.dart';
// import '../../../../../search/lib/presentation/pages/search_page_tvshow.dart';
import 'package:core/presentation/pages/tvshow/top_rated_tvshows_page.dart';
import 'package:core/presentation/pages/tvshow/watchlist_tvshows_page.dart';
import 'package:core/presentation/provider/tvshow/tvshow_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    Future.microtask(
        () => Provider.of<TvshowListNotifier>(context, listen: false)
          ..fetchOnTheAirTvshows()
          ..fetchPopularTvshows()
          ..fetchTopRatedTvshows());
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
              Consumer<TvshowListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirTvshowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvshowList(data.onTheAirTvshows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvshowsPage.ROUTE_NAME),
              ),
              Consumer<TvshowListNotifier>(builder: (context, data, child) {
                final state = data.popularTvshowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvshowList(data.popularTvshows);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvshowsPage.ROUTE_NAME),
              ),
              Consumer<TvshowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvshowsState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvshowList(data.topRatedTvshows);
                } else {
                  return Text('Failed');
                }
              }),
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
