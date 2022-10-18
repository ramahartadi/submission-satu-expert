import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

class RemoveWatchlistTvshow {
  final TvshowRepository repository;

  RemoveWatchlistTvshow(this.repository);

  Future<Either<Failure, String>> execute(TvshowDetail tvshow) {
    return repository.removeWatchlistTvshow(tvshow);
  }
}
