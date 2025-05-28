import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  final String name;
  final String? posterPath;
  final String overview;
  final double voteAverage;
  final String firstAirDate;

  const TvShow({
    required this.name,
    this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.firstAirDate,
  });

  @override
  List<Object?> get props => [
    name,
    posterPath,
    overview,
    voteAverage,
    firstAirDate,
  ];
}
