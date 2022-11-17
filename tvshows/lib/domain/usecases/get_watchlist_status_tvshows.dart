import '../repositories/tvshow_repository.dart';

class GetWatchlistStatusTv {
  final TvshowRepository repository;

  GetWatchlistStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvshow(id);
  }
}
