import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';

class RemoveWatchlistTvshow {
  final TvshowRepository repository;

  RemoveWatchlistTvshow(this.repository);

  Future<Either<Failure, String>> execute(TvshowDetail tvshow) {
    return repository.removeWatchlistTvshow(tvshow);
  }
}
