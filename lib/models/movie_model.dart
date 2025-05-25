class Movie {
  final bool adult;
  final String? backdropPath; // nullable
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath; // nullable
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  //from jason to dart
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] ?? false,
      backdropPath: json['backdropPath'] as String?,
      genreIds: List<int>.from(json['genreIds'] ?? []),
      id: json['id'] ?? 0,
      originalLanguage: json['originalLanguage'] ?? "",
      originalTitle: json['originalTitle'] ?? "",
      overview: json['overview'] ?? "",
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['posterPath'] as String?,
      releaseDate: json['releaseDate'] ?? "",
      title: json['title'] ?? "",
      video: json['video'] ?? false,
      voteAverage: (json['voteAverage'] ?? 0).toDouble(),
      voteCount: json['voteCount'] ?? 0,
    );
  }
}
