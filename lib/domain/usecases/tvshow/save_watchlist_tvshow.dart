import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow_detail.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

class SaveWatchlistTvshow {
  final TvshowRepository repository;

  SaveWatchlistTvshow(this.repository);

  Future<Either<Failure, String>> execute(TvshowDetail tvshow) {
    return repository.saveWatchlistTvshow(tvshow);
  }
}
