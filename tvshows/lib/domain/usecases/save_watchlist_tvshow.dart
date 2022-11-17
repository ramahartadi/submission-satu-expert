import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/tvshow_detail.dart';
import '../repositories/tvshow_repository.dart';

class SaveWatchlistTvshow {
  final TvshowRepository repository;

  SaveWatchlistTvshow(this.repository);

  Future<Either<Failure, String>> execute(TvshowDetail tvshow) {
    return repository.saveWatchlistTvshow(tvshow);
  }
}
