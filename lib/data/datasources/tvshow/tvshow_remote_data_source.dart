import 'dart:convert';
import 'package:ditonton/data/models/tvshow/tvshow_detail_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_model.dart';
import 'package:ditonton/data/models/tvshow/tvshow_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class TvshowRemoteDataSource {
  Future<List<TvshowModel>> getOnTheAirTvshows();
  Future<List<TvshowModel>> getPopularTvshows();
  Future<List<TvshowModel>> getTopRatedTvshows();
  Future<TvshowDetailResponse> getTvshowDetail(int id);
  Future<List<TvshowModel>> getTvshowRecommendations(int id);
  Future<List<TvshowModel>> searchTvshow(String query);
}

class TvshowRemoteDataSourceImpl implements TvshowRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvshowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvshowModel>> getOnTheAirTvshows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvshowDetailResponse> getTvshowDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTvshowRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getPopularTvshows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> getTopRatedTvshows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvshowModel>> searchTvshow(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvshowResponse.fromJson(json.decode(response.body)).tvshowList;
    } else {
      throw ServerException();
    }
  }
}
