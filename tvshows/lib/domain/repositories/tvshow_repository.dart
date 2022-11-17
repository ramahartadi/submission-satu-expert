import '../entities/tvshow_detail.dart';
import '../entities/tvshow.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TvshowRepository {
  Future<Either<Failure, List<Tvshow>>> getOnTheAirTvshows();
  Future<Either<Failure, List<Tvshow>>> getPopularTvshows();
  Future<Either<Failure, List<Tvshow>>> getTopRatedTvshows();
  Future<Either<Failure, TvshowDetail>> getTvshowDetail(int id);
  Future<Either<Failure, List<Tvshow>>> getTvshowRecommendations(int id);
  Future<Either<Failure, List<Tvshow>>> searchTvshow(String query);
  Future<Either<Failure, String>> saveWatchlistTvshow(TvshowDetail tv);
  Future<Either<Failure, String>> removeWatchlistTvshow(TvshowDetail tv);
  Future<bool> isAddedToWatchlistTvshow(int id);
  Future<Either<Failure, List<Tvshow>>> getWatchlistTvshows();
}
