import 'package:moviewave/core/usecases/usecase.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/tv_show/domain/entities/tv_show.dart';
import 'package:moviewave/src/tv_show/domain/repos/tv_show_repo.dart';

class GetTopRated extends UsecaseWithoutParams<List<TvShow>> {
  const GetTopRated(this._repo);
  final TvShowRepo _repo;

  @override
  ResultFuture<List<TvShow>> call() => _repo.getTopRated();
}
