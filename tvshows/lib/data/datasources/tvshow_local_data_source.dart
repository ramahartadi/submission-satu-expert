import 'package:core/data/datasources/db/tvshow_database_helper.dart';
import 'package:tvshows/data/models/tvshow_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvshowLocalDataSource {
  Future<String> insertWatchlistTvshow(TvshowTable tvshow);
  Future<String> removeWatchlistTvshow(TvshowTable tvshow);
  Future<TvshowTable?> getTvshowById(int id);
  Future<List<TvshowTable>> getWatchlistTvshows();
}

class TvshowLocalDataSourceImpl implements TvshowLocalDataSource {
  final DatabaseHelperTvshow databaseHelperTvshow;

  TvshowLocalDataSourceImpl({required this.databaseHelperTvshow});

  @override
  Future<String> insertWatchlistTvshow(TvshowTable tvshow) async {
    try {
      await databaseHelperTvshow.insertWatchlistTvshow(tvshow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvshow(TvshowTable tvshow) async {
    try {
      await databaseHelperTvshow.removeWatchlistTvshow(tvshow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvshowTable?> getTvshowById(int id) async {
    final result = await databaseHelperTvshow.getTvshowById(id);
    if (result != null) {
      return TvshowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvshowTable>> getWatchlistTvshows() async {
    final result = await databaseHelperTvshow.getWatchlistTvshows();
    return result.map((data) => TvshowTable.fromMap(data)).toList();
  }
}
