import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:tvshows/presentation/provider/watchlist_tvshow_notifier.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvshow';

  @override
  _WatchlistTvshowsPageState createState() => _WatchlistTvshowsPageState();
}

class _WatchlistTvshowsPageState extends State<WatchlistTvshowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvshowNotifier>(context, listen: false)
            .fetchWatchlistTvshows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistTvshowNotifier>(context, listen: false)
        .fetchWatchlistTvshows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvshowNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = data.watchlistTvshows[index];
                  return TvshowCard(tvshow);
                },
                itemCount: data.watchlistTvshows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
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