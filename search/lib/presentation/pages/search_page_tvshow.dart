import 'package:core/core.dart';
// import 'package:core/presentation/provider/tvshow/tvshow_search_notifier.dart';
import 'package:core/presentation/widgets/tvshow_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc_tvshow.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
// import 'package:provider/provider.dart';

class SearchPageTvshow extends StatelessWidget {
  static const ROUTE_NAME = '/tvshowsearch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Tvshow'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchBlocTvshow>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchBlocTvshow, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasDataTvshow) {
                  final resultTvshow = state.resultTvshow;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvshow = resultTvshow[index];
                        return TvshowCard(tvshow);
                      },
                      itemCount: resultTvshow.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
