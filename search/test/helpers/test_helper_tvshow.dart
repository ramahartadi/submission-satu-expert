import 'package:core/data/datasources/db/tvshow_database_helper.dart';
import 'package:tvshows/data/datasources/tvshow_local_data_source.dart';
import 'package:tvshows/data/datasources/tvshow_remote_data_source.dart';
import 'package:tvshows/domain/repositories/tvshow_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvshowRepository,
  TvshowRemoteDataSource,
  TvshowLocalDataSource,
  DatabaseHelperTvshow,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
