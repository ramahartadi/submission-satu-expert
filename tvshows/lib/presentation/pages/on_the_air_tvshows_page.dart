import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';

import '../bloc/list_tvshows/list_tvshows_event.dart';
import '../bloc/list_tvshows/list_tvshows_state.dart';
import '../bloc/list_tvshows/on_the_air_tvshows_bloc.dart';

class OnTheAirTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tvshow';

  @override
  _OnTheAirTvshowsPageState createState() => _OnTheAirTvshowsPageState();
}

class _OnTheAirTvshowsPageState extends State<OnTheAirTvshowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvshowsBloc>(context).add(OnListTvshowsCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tvshows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvshowsBloc, TvshowsState>(
          builder: (context, state) {
            if (state is TvshowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvshowsHasData) {
              final tvshows = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvshow = tvshows[index];
                  return TvshowCard(tvshow);
                },
                itemCount: tvshows.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as TvshowsError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
