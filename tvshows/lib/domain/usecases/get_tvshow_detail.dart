import 'package:dartz/dartz.dart';
import '../entities/tvshow_detail.dart';
import '../repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvshowDetail {
  final TvshowRepository repository;

  GetTvshowDetail(this.repository);

  Future<Either<Failure, TvshowDetail>> execute(int id) {
    return repository.getTvshowDetail(id);
  }
}
