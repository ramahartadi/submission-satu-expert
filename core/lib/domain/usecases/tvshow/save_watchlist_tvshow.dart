import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';

class SaveWatchlistTvshow {
  final TvshowRepository repository;

  SaveWatchlistTvshow(this.repository);

  Future<Either<Failure, String>> execute(TvshowDetail tvshow) {
    return repository.saveWatchlistTvshow(tvshow);
  }
}
