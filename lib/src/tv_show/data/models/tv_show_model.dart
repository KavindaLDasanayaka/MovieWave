import 'dart:convert';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/tv_show/domain/entities/tv_show.dart';

class TvShowModel extends TvShow {
  const TvShowModel({
    required super.name,
    super.posterPath,
    required super.overview,
    required super.voteAverage,
    required super.firstAirDate,
  });

  TvShowModel copyWith({
    String? name,
    String? posterPath,
    String? overview,
    double? voteAverage,
    String? firstAirDate,
  }) {
    return TvShowModel(
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      overview: overview ?? this.overview,
      voteAverage: voteAverage ?? this.voteAverage,
      firstAirDate: firstAirDate ?? this.firstAirDate,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'name': name,
      'poster_path': posterPath,
      'overview': overview,
      'vote_average': voteAverage,
      'first_air_date': firstAirDate,
    };
  }

  factory TvShowModel.fromMap(DataMap map) {
    return TvShowModel(
      name: map['name'] as String,
      posterPath: map['poster_path'] as String?,
      overview: map['overview'] as String,
      voteAverage: map['vote_average'] as double,
      firstAirDate: map['first_air_date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvShowModel.fromJson(String source) =>
      TvShowModel.fromMap(json.decode(source) as DataMap);

  @override
  String toString() {
    return 'TvShowModel(name: $name, posterPath: $posterPath, overview: $overview, voteAverage: $voteAverage, firstAirDate: $firstAirDate)';
  }
}
