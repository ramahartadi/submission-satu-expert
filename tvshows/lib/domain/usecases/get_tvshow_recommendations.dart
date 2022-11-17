import 'package:dartz/dartz.dart';
import '../entities/tvshow.dart';
import '../repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvshowRecommendations {
  final TvshowRepository repository;

  GetTvshowRecommendations(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute(id) {
    return repository.getTvshowRecommendations(id);
  }
}
