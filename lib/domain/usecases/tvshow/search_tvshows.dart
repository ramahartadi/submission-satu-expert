import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvshow/tvshow.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';

class SearchTvshows {
  final TvshowRepository repository;

  SearchTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute(String query) {
    return repository.searchTvshow(query);
  }
}
