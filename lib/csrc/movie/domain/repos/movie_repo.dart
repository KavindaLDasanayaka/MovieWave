import 'package:moviewave/core/common/entities/movie.dart';
import 'package:moviewave/core/utils/typedefs.dart';

abstract class MovieRepo {
  ResultFuture<List<Movie>> getUpcomingMovies({required int page});
}
