import '../repositories/tvshow_repository.dart';

class GetWatchListStatusTvshow {
  final TvshowRepository repository;

  GetWatchListStatusTvshow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvshow(id);
  }
}
