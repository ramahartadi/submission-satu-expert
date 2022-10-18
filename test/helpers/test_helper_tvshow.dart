import 'package:ditonton/data/datasources/db/tvshow_database_helper.dart';
import 'package:ditonton/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:ditonton/data/datasources/tvshow/tvshow_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tvshow_repository.dart';
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
