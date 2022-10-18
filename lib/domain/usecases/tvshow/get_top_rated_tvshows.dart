import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

class GetTopRatedTvshows {
  final TvshowRepository repository;

  GetTopRatedTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute() {
    return repository.getTopRatedTvshows();
  }
}
