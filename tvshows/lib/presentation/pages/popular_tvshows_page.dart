import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvshows/presentation/provider/popular_tvshows_notifier.dart';
import 'package:tvshows/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';

import '../bloc/list_tvshows/list_tvshows_event.dart';
import '../bloc/list_tvshows/list_tvshows_state.dart';
import '../bloc/list_tvshows/popular_tvshows_bloc.dart';
// import 'package:provider/provider.dart';

class PopularTvshowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvshow';

  @override
  _PopularTvshowsPageState createState() => _PopularTvshowsPageState();
}

class _PopularTvshowsPageState extends State<PopularTvshowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<PopularTvshowsBloc>(context).add(OnListTvshowsCalled());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tvshows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvshowsBloc, TvshowsState>(
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
