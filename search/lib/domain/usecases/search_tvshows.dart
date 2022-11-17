import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:tvshows/domain/repositories/tvshow_repository.dart';

class SearchTvshows {
  final TvshowRepository repository;

  SearchTvshows(this.repository);

  Future<Either<Failure, List<Tvshow>>> execute(String query) {
    return repository.searchTvshow(query);
  }
}
