import 'package:moviewave/src/movie/data/models/movie_model.dart';

abstract class MovieRemoteDataSrc {
  const MovieRemoteDataSrc();

  Future<List<MovieModel>> getUpcomingMovies({required int page});
}
