import 'package:dartz/dartz.dart';
import '../entities/tvshow.dart';
import '../repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlistTvshows {
  final TvshowRepository _repository;

  GetWatchlistTvshows(this._repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return _repository.getWatchlistTvshows();
  }
}
