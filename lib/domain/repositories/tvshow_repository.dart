import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/common/failure.dart';
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
