import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/movie/domain/entities/movie.dart';

abstract class MovieRepo {
  ResultFuture<List<Movie>> getUpcomingMovies({required int page});
}
