import 'package:dartz/dartz.dart';
import '../entities/tvshow.dart';
import '../repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlistTv {
  final TvshowRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return _repository.getWatchlistTvshows();
  }
}
