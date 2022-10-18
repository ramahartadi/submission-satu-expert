import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetOnTheAirTvshows {
  final TvshowRepository repository;

  GetOnTheAirTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getOnTheAirTvshows();
  }
}
