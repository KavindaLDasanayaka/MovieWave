import 'package:moviewave/core/common/entities/tv_show.dart';
import 'package:moviewave/core/utils/typedefs.dart';

abstract class TvShowRepo {
  ResultFuture<List<TvShow>> getPopular();
  ResultFuture<List<TvShow>> getTopRated();
}
