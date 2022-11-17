import 'package:tvshows/domain/entities/tvshow.dart';
import 'package:equatable/equatable.dart';

class TvshowModel extends Equatable {
  TvshowModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
    required this.originalLanguage,
  });
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;
  final List<String> originCountry;
  final String? originalLanguage;

  factory TvshowModel.fromJson(Map<String, dynamic> json) => TvshowModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
      );
  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": originCountry,
        "original_language": originalLanguage,
      };
  Tvshow toEntity() {
    return Tvshow(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
