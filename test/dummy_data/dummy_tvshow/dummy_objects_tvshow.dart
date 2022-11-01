import 'package:core/data/models/tvshow/tvshow_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';

final testTvshow = Tvshow(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars");

final testTvshowList = [testTvshow];

final testTvshowDetail = TvshowDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  homepage: "http://www.hbo.com/game-of-thrones",
  inProduction: false,
  lastAirDate: "2019-05-19",
  // nextEpisodeToAir: null,
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalLanguage: 'en',
  popularity: 369.594,
  status: 'Ended',
  tagline: 'Winter Is Coming',
  type: 'Scripted',
);

final testWatchlistTvshow = Tvshow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvshowTable = TvshowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvshowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
