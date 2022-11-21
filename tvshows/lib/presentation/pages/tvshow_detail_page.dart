import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tvshow.dart';
import '../../domain/entities/tvshow_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/tvshow_detail/tvshow_detail_bloc.dart';
import '../bloc/tvshow_recommendation/tvshow_recommendation_bloc.dart';
import '../bloc/watch_list_tvshow/tvshow_watchlist_bloc.dart';

class TvshowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tvshowdetail';

  final int id;
  TvshowDetailPage({required this.id});

  @override
  _TvshowDetailPageState createState() => _TvshowDetailPageState();
}

class _TvshowDetailPageState extends State<TvshowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvshowDetailBloc>(context)
          .add(FetchTvshowDetailEvent((widget.id)));
      BlocProvider.of<WatchlistTvshowBloc>(context)
          .add(LoadWatchlistTvshowStatus(widget.id));
      BlocProvider.of<RecommendationTvshowBloc>(context)
          .add(FetchTvshowsRecommendationEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tvshowsRecommendation =
        context.select<RecommendationTvshowBloc, List<Tvshow>>((value) {
      var state = value.state;
      if (state is TvshowsRecommendationHasData) {
        return (state).tvshow;
      }
      return [];
    });

    var isAddedToWatchlist = context.select<WatchlistTvshowBloc, bool>((value) {
      var state = value.state;
      if (state is LoadWatchlistData) {
        return state.status;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<TvshowDetailBloc, TvshowDetailState>(
        builder: (context, state) {
          if (state is TvshowDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvshowDetailHasData) {
            final tvshow = state.tvshow;
            return SafeArea(
              child: DetailContent(
                tvshow,
                tvshowsRecommendation,
                isAddedToWatchlist,
              ),
            );
          } else {
            return const Text('Failed to fetch date');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvshowDetail tvshow;
  final List<Tvshow> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvshow, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvshow.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  BlocProvider.of<WatchlistTvshowBloc>(context,
                                          listen: false)
                                      .add(SaveWatchlistTvshowEvent(tvshow));
                                } else {
                                  BlocProvider.of<WatchlistTvshowBloc>(context,
                                          listen: false)
                                      .add(RemoveWatchlistTvshowEvent(tvshow));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTvshowBloc>(
                                            context)
                                        .state;
                                String message = '';

                                if (state is LoadWatchlistData) {
                                  message = isAddedWatchlist
                                      ? WatchlistTvshowBloc
                                          .watchlistRemoveSuccessMessage
                                      : WatchlistTvshowBloc
                                          .watchlistAddSuccessMessage;
                                } else {
                                  message = isAddedWatchlist == false
                                      ? WatchlistTvshowBloc
                                          .watchlistAddSuccessMessage
                                      : WatchlistTvshowBloc
                                          .watchlistRemoveSuccessMessage;
                                }

                                if (message ==
                                        WatchlistTvshowBloc
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        WatchlistTvshowBloc
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          duration: Duration(milliseconds: 500),
                                          content: Text(
                                            message,
                                          )));
                                  //LOAD NEW STATUS
                                  BlocProvider.of<WatchlistTvshowBloc>(context)
                                      .add(
                                          LoadWatchlistTvshowStatus(tvshow.id));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvshow.genres),
                            ),
                            Text(
                              ('${tvshow.numberOfEpisodes} Episodes'),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvshow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvshow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvshow.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvshow = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvshowDetailPage.ROUTE_NAME,
                                          arguments: tvshow.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvshow.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
