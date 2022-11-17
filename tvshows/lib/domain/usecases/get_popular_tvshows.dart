import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/tvshow.dart';
import '../repositories/tvshow_repository.dart';

class GetPopularTvshows {
  final TvshowRepository repository;

  GetPopularTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getPopularTvshows();
  }
}
