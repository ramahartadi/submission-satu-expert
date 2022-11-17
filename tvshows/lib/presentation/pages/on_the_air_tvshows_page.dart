import 'package:core/utils/state_enum.dart';
import 'package:tvshows/presentation/provider/on_the_air_tvshows_notifier.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tvshow';

  @override
  _OnTheAirTvshowsPageState createState() => _OnTheAirTvshowsPageState();
}

class _OnTheAirTvshowsPageState extends State<OnTheAirTvshowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvshowsNotifier>(context, listen: false)
            .fetchOnTheAirTvshows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tvshows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvshowsNotifier>(
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
