import 'package:core/domain/entities/tvshow/tvshow_detail.dart';
import 'package:core/domain/entities/tvshow/tvshow.dart';
import 'package:equatable/equatable.dart';

class TvshowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvshowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvshowTable.fromEntity(TvshowDetail tvshow) => TvshowTable(
        id: tvshow.id,
        name: tvshow.name,
        posterPath: tvshow.posterPath,
        overview: tvshow.overview,
      );

  factory TvshowTable.fromMap(Map<String, dynamic> map) => TvshowTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Tvshow toEntity() => Tvshow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
