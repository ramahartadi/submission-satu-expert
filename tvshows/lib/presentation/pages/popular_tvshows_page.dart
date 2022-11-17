import 'package:core/utils/state_enum.dart';
import 'package:tvshows/presentation/provider/popular_tvshows_notifier.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvshow';

  @override
  _PopularTvshowsPageState createState() => _PopularTvshowsPageState();
}

class _PopularTvshowsPageState extends State<PopularTvshowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvshowsNotifier>(context, listen: false)
            .fetchPopularTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tvshows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvshowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = data.tvshows[index];
                  return TvshowCard(tvshow);
                },
                itemCount: data.tvshows.length,
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
}
