import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';
import 'package:core/utils/failure.dart';

class GetTvshowDetail {
  final TvshowRepository repository;

  GetTvshowDetail(this.repository);

  Future<Either<Failure, TvshowDetail>> execute(int id) {
    return repository.getTvshowDetail(id);
  }
}
