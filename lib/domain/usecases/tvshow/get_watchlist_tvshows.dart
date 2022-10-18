import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTvshows {
  final TvshowRepository _repository;

  GetWatchlistTvshows(this._repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return _repository.getWatchlistTvshows();
  }
}
