import 'package:moviewave/core/common/entities/movie.dart';
import 'package:moviewave/core/usecases/usecase.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/csrc/movie/domain/repos/movie_repo.dart';

class GetUpcomingMovies extends UsecaseWithParams<List<Movie>, int> {
  const GetUpcomingMovies(this._repo);
  final MovieRepo _repo;

  @override
  ResultFuture<List<Movie>> call(params) =>
      _repo.getUpcomingMovies(page: params);
}
