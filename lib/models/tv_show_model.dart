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
      name: json['name'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      firstAirDate: json['first_air_date'],
    );
  }
}
