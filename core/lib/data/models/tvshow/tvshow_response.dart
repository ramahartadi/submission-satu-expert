import 'package:core/data/models/tvshow/tvshow_model.dart';
import 'package:equatable/equatable.dart';

class TvshowResponse extends Equatable {
  final List<TvshowModel> tvshowList;

  TvshowResponse({required this.tvshowList});

  factory TvshowResponse.fromJson(Map<String, dynamic> json) => TvshowResponse(
        tvshowList: List<TvshowModel>.from((json["results"] as List)
            .map((x) => TvshowModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvshowList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvshowList];
}
