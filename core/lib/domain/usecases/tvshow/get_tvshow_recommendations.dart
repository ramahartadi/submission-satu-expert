import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvshowRecommendations {
  final TvshowRepository repository;

  GetTvshowRecommendations(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute(id) {
    return repository.getTvshowRecommendations(id);
  }
}
