import 'package:dartz/dartz.dart';
import '../entities/tvshow.dart';
import '../repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetOnTheAirTvshows {
  final TvshowRepository repository;

  GetOnTheAirTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getOnTheAirTvshows();
  }
}
