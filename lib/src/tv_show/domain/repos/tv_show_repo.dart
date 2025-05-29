import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/tv_show/domain/entities/tv_show.dart';

abstract class TvShowRepo {
  ResultFuture<List<TvShow>> getPopular();
  ResultFuture<List<TvShow>> getTopRated();
}
