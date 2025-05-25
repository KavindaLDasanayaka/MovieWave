class TvShow {
  final String name;
  final String? posterPath;
  final String overview;
  final double voteAverage;
  final String firstAirDate;

  TvShow({
    required this.name,
    this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.firstAirDate,
  });

  //from json to dart
  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      name: json['name'] ?? "",
      posterPath: json['posterPath'] as String?,
      overview: json['overview'] ?? "",
      voteAverage: (json['voteAverage'] ?? 0).toDouble(),
      firstAirDate: json['firstAirDate'] ?? "",
    );
  }
}
