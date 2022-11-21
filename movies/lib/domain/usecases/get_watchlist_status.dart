import 'package:movies/domain/repositories/movie_repository.dart';

class GetWatchlistStatusMovie {
  final MovieRepository repository;

  GetWatchlistStatusMovie(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
