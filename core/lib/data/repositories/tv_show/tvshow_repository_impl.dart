import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/datasources/tvshow/tvshow_local_data_source.dart';
import 'package:core/data/datasources/tvshow/tvshow_remote_data_source.dart';
import 'package:core/data/models/tvshow/tvshow_table.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/repositories/tvshow_repository.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';

class TvshowRepositoryImpl implements TvshowRepository {
  final TvshowRemoteDataSource remoteDataSource;
  final TvshowLocalDataSource localDataSource;

  TvshowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tvshow>>> getOnTheAirTvshows() async {
    try {
      final result = await remoteDataSource.getOnTheAirTvshows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvshowDetail>> getTvshowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvshowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTvshowRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvshowRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getPopularTvshows() async {
    try {
      final result = await remoteDataSource.getPopularTvshows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getTopRatedTvshows() async {
    try {
      final result = await remoteDataSource.getTopRatedTvshows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tvshow>>> searchTvshow(String query) async {
    try {
      final result = await remoteDataSource.searchTvshow(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvshow(
      TvshowDetail tvshow) async {
    try {
      final result = await localDataSource
          .insertWatchlistTvshow(TvshowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvshow(
      TvshowDetail tvshow) async {
    try {
      final result = await localDataSource
          .removeWatchlistTvshow(TvshowTable.fromEntity(tvshow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlistTvshow(int id) async {
    final result = await localDataSource.getTvshowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tvshow>>> getWatchlistTvshows() async {
    final result = await localDataSource.getWatchlistTvshows();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
