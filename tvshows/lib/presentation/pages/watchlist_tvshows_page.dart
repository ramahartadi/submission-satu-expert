import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tvshows/presentation/provider/watchlist_tvshow_notifier.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';

import '../bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';

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
    Future.microtask(() {
      BlocProvider.of<WatchListTvshowBloc>(context)
          .add(FetchTvshowWatchlistEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchListTvshowBloc>(context, listen: false)
        .add(FetchTvshowWatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListTvshowBloc, TvshowWatchlistState>(
          builder: (context, state) {
            if (state is TvshowWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvshowWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = state.tvshow[index];
                  return TvshowCard(tvshow);
                },
                itemCount: state.tvshow.length,
              );
            } else if (state is TvshowWatchlistHasError) {
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
