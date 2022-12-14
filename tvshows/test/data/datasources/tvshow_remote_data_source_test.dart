import 'dart:convert';
import 'package:tvshows/data/datasources/tvshow_remote_data_source.dart';
import 'package:tvshows/data/models/tvshow_detail_model.dart';
import 'package:tvshows/data/models/tvshow_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tvshow.mocks.dart';
import '../../../../test/json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvshowRemoteDataSourceImpl dataSourcetv;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourcetv = TvshowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air Tvshow', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/on_the_air_tvshow.json')))
        .tvshowList;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/on_the_air_tvshow.json'),
                200,
              ));
      // act
      final result = await dataSourcetv.getOnTheAirTvshows();
      // assert
      expect(result, equals(tTvshowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourcetv.getOnTheAirTvshows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tvshow', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tvshow.json')))
        .tvshowList;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tvshow.json'), 200));
      // act
      final result = await dataSourcetv.getPopularTvshows();
      // assert
      expect(result, tTvshowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourcetv.getPopularTvshows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tvshow', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tvshow.json')))
        .tvshowList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_tvshow.json'), 200));
      // act
      final result = await dataSourcetv.getTopRatedTvshows();
      // assert
      expect(result, tTvshowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourcetv.getTopRatedTvshows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvshowDetail = TvshowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tvshow_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tvshow_detail.json'), 200));
      // act
      final result = await dataSourcetv.getTvshowDetail(tId);
      // assert
      expect(result, equals(tTvshowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourcetv.getTvshowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvshowList = TvshowResponse.fromJson(
            json.decode(readJson('dummy_data/tvshow_recommendations.json')))
        .tvshowList;
    final tId = 1;

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvshow_recommendations.json'), 200));
      // act
      final result = await dataSourcetv.getTvshowRecommendations(tId);
      // assert
      expect(result, equals(tTvshowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourcetv.getTvshowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
