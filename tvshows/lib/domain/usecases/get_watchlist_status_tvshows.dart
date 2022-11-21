import '../repositories/tvshow_repository.dart';

class GetWatchlistStatusTvshow {
  final TvshowRepository repository;

  GetWatchlistStatusTvshow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvshow(id);
  }
}
