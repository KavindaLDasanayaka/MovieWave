import 'package:moviewave/core/common/models/tv_show_model.dart';

abstract class TvShowRemoteDataSrc {
  const TvShowRemoteDataSrc();

  Future<List<TvShowModel>> getPopular();
  Future<List<TvShowModel>> getTopRated();
}
